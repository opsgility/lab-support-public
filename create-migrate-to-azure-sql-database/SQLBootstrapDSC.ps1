Configuration Main
{

Param ([string] $nodeName, [string] $user, [string] $pword, [string] $dbsource, [string] $sqlConfigUrl )

Import-DscResource -ModuleName PSDesiredStateConfiguration

Node $nodeName
  {
    Script ConfigureSql
    {
        TestScript = {
            return $false
        }
        SetScript ={
        
            
        $pword =  ConvertTo-SecureString "$pword" -AsPlainText -Force
        $credential = New-Object System.Management.Automation.PSCredential("$env:COMPUTERNAME\$user", $pword)
            
		### Create Directory
		New-Item -ItemType Directory -Force -Path C:\ -Name OpsgilityTraining
        
        Enable-PSRemoting -Force

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
		$dbsource = "https://opsgilityweb.blob.core.windows.net/online-labs/create-migrate-to-azure-sql-database/StudentFiles.zip"
		$dbdestination = "C:\OpsgilityTraining\AdventureWorks2016CTP3.bak"
		Invoke-WebRequest $dbsource -OutFile $dbdestination 

        ### Extract Zip -- <<<comment this line out for uncompressed db files>>>
        Expand-Archive $dbdestination -DestinationPath C:\OpsgilityTraining -Force

		$mdf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("'AdventureWorksDW2014_Data", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2016CTP3_Data.mdf")
		$ldf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorksDW2014_Log", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2016CTP3_Log.ldf")

		# Restore the database from the backup
		Restore-SqlDatabase -ServerInstance Localhost -Database AdventureWorks `
					-BackupFile $dbdestination -RelocateFile @($mdf,$ldf) -ReplaceDatabase 
		New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Endpoint" -Direction Inbound -Protocol TCP -LocalPort 5022 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Load Balancer Probe Port" -Direction Inbound -Protocol TCP -LocalPort 59999 -Action allow 

		# Add local administrators group as sysadmin
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER SERVER ROLE sysadmin ADD MEMBER [BUILTIN\Administrators]"

		# Put the database into full recovery and run a backup (required for SQL AG)
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER DATABASE AdventureWorks SET RECOVERY FULL"
		Backup-SqlDatabase -ServerInstance Localhost -Database AdventureWorks 
    
        Disable-PSRemoting -Force

		}
     GetScript = {@{Result = "ConfigureSql"}}
	}
  }
}