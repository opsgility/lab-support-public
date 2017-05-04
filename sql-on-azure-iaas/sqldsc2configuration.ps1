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

		New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound –Protocol TCP –LocalPort 1433 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Endpoint" -Direction Inbound –Protocol TCP –LocalPort 5022 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Load Balancer Probe Port" -Direction Inbound –Protocol TCP –LocalPort 59999 -Action allow 

		#Add local administrators group as sysadmin
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER SERVER ROLE sysadmin ADD MEMBER [BUILTIN\Administrators]"
		}
     GetScript = {@{Result = "ConfigureSql"}}
	}
  }
}