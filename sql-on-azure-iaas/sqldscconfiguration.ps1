Configuration Main
{

Param ( [string] $nodeName )

Import-DscResource -ModuleName PSDesiredStateConfiguration

Node $nodeName
  {
    Script ConfigureSql
    {
        TestScript = {
            return $false
        }
        SetScript ={
		
		### Create Directory
		New-Item -ItemType Directory -Force -Path C:\ -Name OpsgilityTraining

		# Setup mixed mode authentication
		Import-Module "sqlps" -DisableNameChecking
		[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
		$sqlesq = new-object ('Microsoft.SqlServer.Management.Smo.Server') Localhost
		$sqlesq.Settings.LoginMode = [Microsoft.SqlServer.Management.Smo.ServerLoginMode]::Mixed
		$sqlesq.Alter() 

		# Enable TCP Server Network Protocol
		$smo = 'Microsoft.SqlServer.Management.Smo.'  
		$wmi = new-object ($smo + 'Wmi.ManagedComputer').  
		$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"  
		$Tcp = $wmi.GetSmoObject($uri)  
		$Tcp.IsEnabled = $true  
		$Tcp.Alter() 

		# Restart the SQL Server service
		Restart-Service -Name "MSSQLSERVER" -Force

		# Re-enable the sa account and set a new password to enable login
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER LOGIN sa ENABLE"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER LOGIN sa WITH PASSWORD = 'Demo@pass123'"

		# Get the Adventure works database backup 
		$dbsource = "http://opsgilityweb.blob.core.windows.net/public/AdventureWorks2016CTP3.bak"
		$dbdestination = "C:\OpsgilityTraining\AdventureWorks2016CTP3.bak"
		Invoke-WebRequest $dbsource -OutFile $dbdestination 

		$mdf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorks2016CTP3_Data", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2016CTP3_Data.mdf")
		$ldf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorks2016CTP3_Log", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2016CTP3_Log.ldf")
		$mod = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorks2016CTP3_mod", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2016CTP3_mod")

		# Restore the database from the backup
		Restore-SqlDatabase -ServerInstance Localhost -Database AdventureWorks `
					-BackupFile $dbdestination -RelocateFile @($mdf,$ldf,$mod) -ReplaceDatabase 
		New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound –Protocol TCP –LocalPort 1433 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Endpoint" -Direction Inbound –Protocol TCP –LocalPort 5022 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Load Balancer Probe Port" -Direction Inbound –Protocol TCP –LocalPort 59999 -Action allow 

		# Add local administrators group as sysadmin
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER SERVER ROLE sysadmin ADD MEMBER [BUILTIN\Administrators]"

		# Put the database into full recovery and run a backup (required for SQL AG)
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER DATABASE AdventureWorks SET RECOVERY FULL"
		Backup-SqlDatabase -ServerInstance Localhost -Database AdventureWorks 
	
		}
     GetScript = {@{Result = "ConfigureSql"}}
	}
  }
}