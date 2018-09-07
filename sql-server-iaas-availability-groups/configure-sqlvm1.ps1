param($sourceFileUrl="", $destinationFolder="", $labName="", $domain="", $user="", $password="")
$ErrorActionPreference = 'SilentlyContinue'

Set-MpPreference -DisableRealtimeMonitoring $true

# This code block configures SQL Server to use instant file initialization. 
# This makes all data file allocations much faster (read:database restores). 
# This also makes the restore much more reliable as it was failing a lot with timeouts.

$sqlaccount = "NT Service\MSSQLSERVER"
$localadmins = "BUILTIN\Administrators"
secedit /export /cfg C:\secexport.txt /areas USER_RIGHTS
$line = Get-Content C:\secexport.txt | Select-String 'SeManageVolumePrivilege'
(Get-Content C:\secexport.txt).Replace($line,"$line,$sqlaccount,$localadmins") | Out-File C:\secimport.txt
secedit /configure /db secedit.sdb /cfg C:\secimport.txt /overwrite /areas USER_RIGHTS /quiet

#put in an artificial wait to let things settle down before we start making changes
Start-Sleep -s 240

if([string]::IsNullOrEmpty($sourceFileUrl) -eq $false -and [string]::IsNullOrEmpty($destinationFolder) -eq $false)
{
    if((Test-Path $destinationFolder) -eq $false)
    {
        New-Item -Path $destinationFolder -ItemType directory
    }
    $splitpath = $sourceFileUrl.Split("/")
    $fileName = $splitpath[$splitpath.Length-1]
    $destinationPath = Join-Path $destinationFolder $fileName

    (New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);

    (new-object -com shell.application).namespace($destinationFolder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)
}

# Disable IE Enhanced Security Configuration
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"

New-Item -Path $adminKey -Force
New-Item -Path $UserKey -Force
New-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
New-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\Software\Microsoft\Internet Explorer\Security"
New-ItemProperty -Path $HKLM -Name "DisableSecuritySettingsCheck" -Value 1 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "DisableSecuritySettingsCheck" -Value 1
Stop-Process -Name Explorer
Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green


if([String]::IsNullOrEmpty($labName) -eq $false){
    $playerFolder = "C:\LabPlayer"
    $sourceFileUrl = "https://opsgilitylabs.blob.core.windows.net/support/player.zip"
    if((Test-Path $playerFolder ) -eq $false)
    {
        New-Item -Path $playerFolder  -ItemType directory
    }
    $splitpath = $sourceFileUrl.Split("/")
    $fileName = $splitpath[$splitpath.Length-1]
    $destinationPath = Join-Path $playerFolder  $fileName
    (New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);
    (new-object -com shell.application).namespace($playerFolder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)
    $sourceFileUrl = "https://opsgilitylabs.blob.core.windows.net/online-labs/$labName/lab-player.json"
    $destinationPath = Join-Path $playerFolder  "lab-player.json"
    (New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);

    $shortCutPath = Join-Path $playerFolder "OpsgilityLabPlayer.lnk"

    Copy-Item -Path $shortCutPath -Destination "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
    Copy-Item -Path $shortCutPath -Destination "C:\Users\demouser\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
}

# Get the Student Files 
# Invoke-WebRequest $sourceFileUrl -OutFile "C:\OpsgilityTraining\StudentFiles.zip" 

# Install Chrome
$Path = $env:TEMP; 
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer

### Extract Zip -- <<<comment this line out for uncompressed db files>>>
Expand-Archive $destinationPath -DestinationPath $destinationFolder -Force
$dbsource = Join-Path $destinationFolder "AdventureWorksDW2016CTP3.bak"

### Create SQLDATA Directory
New-Item -ItemType Directory -Force -Path C:\ -Name SQLDATA
        
$spassword =  ConvertTo-SecureString "$password" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("$env:COMPUTERNAME\$user", $spassword)

Enable-PSRemoting -Force
Invoke-Command -Credential $credential -ComputerName $env:COMPUTERNAME -ArgumentList "Password", $spassword -ScriptBlock { 

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

	    # Open firewall for SQL and SQLAG and Load Balancer
		New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Endpoint" -Direction Inbound -Protocol TCP -LocalPort 5022 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Load Balancer Probe Port" -Direction Inbound -Protocol TCP -LocalPort 59999 -Action allow 

		# Add local administrators group as sysadmin
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER SERVER ROLE sysadmin ADD MEMBER [BUILTIN\Administrators]"

		# Restore the database from the backup
		#$mdf = New-Object 'Microsoft.SqlServer.Management.Smo.RelocateFile, Microsoft.SqlServer.SmoExtended, Version=13.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' -ArgumentList "AdventureWorksDW2014_Data", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2014_Data.mdf"
		#$ldf = New-Object 'Microsoft.SqlServer.Management.Smo.RelocateFile, Microsoft.SqlServer.SmoExtended, Version=13.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' -ArgumentList "AdventureWorksDW2014_Log", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2014_Log.ldf"
		#Restore-SqlDatabase -ServerInstance Localhost -Database AdventureWorksDW2016CTP3 -BackupFile $dbsource -RelocateFile @($mdf,$ldf) -ReplaceDatabase 
        Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "RESTORE DATABASE AdventureWorksDW2016CTP3 FROM DISK = 'C:\OpsgilityTraining\AdventureWorksDW2016CTP3.bak' WITH MOVE 'AdventureWorksDW2014_Data' TO 'C:\SQLDATA\AdventureWorksDW2016CTP3_Data.mdf', MOVE 'AdventureWorksDW2014_Log' TO 'C:\SQLDATA\AdventureWorksDW2016CTP3_Log.ldf'"

		# Put the database into full recovery and run a backup (required for SQL AG)
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER DATABASE AdventureWorksDW2016CTP3 SET RECOVERY FULL"
		Backup-SqlDatabase -ServerInstance Localhost -Database AdventureWorksDW2016CTP3 
}
Disable-PSRemoting -Force

#Join Domain
$domCredential = New-Object System.Management.Automation.PSCredential("$domain\$user", $spassword)
Add-Computer -DomainName "$domain" -Credential $domCredential -Restart -Force

#Add-Computer -DomainName "$domain" -Credential $domCredential -Force

# Download RDP fix 
#$url = "https://opsgilitylabs.blob.core.windows.net/rdp-fix/windows10.0-kb4103723-x64_2adf2ea2d09b3052d241c40ba55e89741121e07e.msu"
#$output = "C:\OpsgilityTraining\windows10.0-kb4103723-x64_2adf2ea2d09b3052d241c40ba55e89741121e07e.msu"

#if((Test-Path -Path "C:\OpsgilityTraining") -eq $false) {

#    New-Item -Path "C:\OpsgilityTraining" -ItemType Directory
#}
#Invoke-WebRequest -Uri $url -OutFile $output

#& wusa.exe C:\OpsgilityTraining\windows10.0-kb4103723-x64_2adf2ea2d09b3052d241c40ba55e89741121e07e.msu /quiet /forcerestart