param($sourceFileUrl="", $destinationFolder="", $labName="", $domain="", $user="", $password="")
$ErrorActionPreference = 'SilentlyContinue'

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

### Extract Zip -- <<<comment this line out for uncompressed db files>>>
Expand-Archive $destinationPath -DestinationPath $destinationFolder -Force
$dbsource = Join-Path $destinationFolder "AdventureWorksDW2016CTP3.bak"

$password =  ConvertTo-SecureString "$password" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("$env:COMPUTERNAME\$user", $password)

Enable-PSRemoting -Force
Invoke-Command -Credential $credential -ComputerName $env:COMPUTERNAME -ArgumentList "Password", $password -ScriptBlock { 

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

		# Restore the database from the backup
		$mdf = New-Object 'Microsoft.SqlServer.Management.Smo.RelocateFile, Microsoft.SqlServer.SmoExtended, Version=13.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' -ArgumentList "AdventureWorksDW2014_Data", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2014_Data.mdf"
		$ldf = New-Object 'Microsoft.SqlServer.Management.Smo.RelocateFile, Microsoft.SqlServer.SmoExtended, Version=13.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' -ArgumentList "AdventureWorksDW2014_Log", "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2014_Log.ldf"
		Restore-SqlDatabase -ServerInstance Localhost -Database AdventureWorksDW2016CTP3 -BackupFile $dbsource -RelocateFile @($mdf,$ldf) -ReplaceDatabase 

	    # Open firewall for SQL and SQLAG and Load Balancer
		New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Endpoint" -Direction Inbound -Protocol TCP -LocalPort 5022 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Load Balancer Probe Port" -Direction Inbound -Protocol TCP -LocalPort 59999 -Action allow 

		# Add local administrators group as sysadmin
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER SERVER ROLE sysadmin ADD MEMBER [BUILTIN\Administrators]"

		# Put the database into full recovery and run a backup (required for SQL AG)
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER DATABASE AdventureWorksDW2016CTP3 SET RECOVERY FULL"
		Backup-SqlDatabase -ServerInstance Localhost -Database AdventureWorksDW2016CTP3 
}
Disable-PSRemoting -Force

#Join Domain
$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)
$user = "$domain\demouser"
$objCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($user, $smPassword)
Add-Computer -DomainName "$domain" -Credential $objCred -Restart -Force