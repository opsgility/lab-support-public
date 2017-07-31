param($dbsource, $sqlConfigUrl)

$logs    = "C:\Logs"
$data    = "C:\Data"
$backups = "C:\Backup" 
$script  = "C:\Script" 

[system.io.directory]::CreateDirectory($logs)
[system.io.directory]::CreateDirectory($data)
[system.io.directory]::CreateDirectory($backups)
[system.io.directory]::CreateDirectory($script)
[system.io.directory]::CreateDirectory("C:\SQLDATA")

$splitpath = $sqlConfigUrl.Split("/")
$fileName = $splitpath[$splitpath.Length-1]
$destinationPath = "$script\configure-sql.ps1"
# Download config script
(New-Object Net.WebClient).DownloadFile($sqlConfigUrl,$destinationPath);

# Get the Adventure works database backup 
$dbdestination = "C:\SQLDATA\AdventureWorks2012.bak"
Invoke-WebRequest $dbsource -OutFile $dbdestination

$password =  ConvertTo-SecureString "$password" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("$env:COMPUTERNAME\$user", $password)

Enable-PSRemoting –force
Invoke-Command -FilePath $destinationPath -Credential $credential -ComputerName $env:COMPUTERNAME
Disable-PSRemoting -Force

New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound –Protocol TCP –LocalPort 1433 -Action allow 
