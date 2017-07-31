$dbdestination = "C:\SQLDATA\AdventureWorks2012.bak"
# Setup the data, backup and log directories as well as mixed mode authentication
Import-Module "sqlps" -DisableNameChecking
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
$sqlesq = new-object ('Microsoft.SqlServer.Management.Smo.Server') Localhost
$sqlesq.Settings.LoginMode = [Microsoft.SqlServer.Management.Smo.ServerLoginMode]::Mixed
$sqlesq.Settings.DefaultFile = $data
$sqlesq.Settings.DefaultLog = $logs
$sqlesq.Settings.BackupDirectory = $backups
$sqlesq.Alter() 

# Restart the SQL Server service
Restart-Service -Name "MSSQLSERVER" -Force
# Re-enable the sa account and set a new password to enable login
Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER LOGIN sa ENABLE" 
Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER LOGIN sa WITH PASSWORD = 'Demo@pass1'"


$mdf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorks2012_Data", "C:\Data\AdventureWorks2012.mdf")
$ldf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorks2012_Log", "C:\Logs\AdventureWorks2012.ldf")

# Restore the database from the backup
Restore-SqlDatabase -ServerInstance Localhost -Database AdventureWorks `
			-BackupFile $dbdestination -RelocateFile @($mdf,$ldf)  