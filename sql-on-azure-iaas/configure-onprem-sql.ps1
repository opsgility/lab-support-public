param($sourceFileUrl="http://cloudworkshop.blob.core.windows.net/migrate-edw/StudentFiles-06-2018.zip", $destinationFolder="C:\LabFiles", $user="demouser", $password="Demo@pass123")
$ErrorActionPreference = 'SilentlyContinue'

Set-MpPreference -DisableRealtimeMonitoring $true

$sqlaccount = "NT Service\MSSQLSERVER"
$localadmins = "BUILTIN\Administrators"
secedit /export /cfg C:\secexport.txt /areas USER_RIGHTS
$line = Get-Content C:\secexport.txt | Select-String 'SeManageVolumePrivilege'
(Get-Content C:\secexport.txt).Replace($line,"$line,$sqlaccount,$localadmins") | Out-File C:\secimport.txt
secedit /configure /db secedit.sdb /cfg C:\secimport.txt /overwrite /areas USER_RIGHTS /quiet

#put in an artificial wait to let things settle down before we start making changes
#Start-Sleep -s 240

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

# Disable IE ESC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer

# Hide Server Manager
$HKLM = "HKLM:\SOFTWARE\Microsoft\ServerManager"
New-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -Type DWord

# Hide Server Manager
$HKCU = "HKEY_CURRENT_USER\Software\Microsoft\ServerManager"
New-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -PropertyType DWORD
Set-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -Type DWord

# Hide Server Manager
$HKLM = "HKLM:\SOFTWARE\Microsoft\ServerManager"
New-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -Type DWord

# Hide Server Manager
$HKCU = "HKEY_CURRENT_USER\Software\Microsoft\ServerManager"
New-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -PropertyType DWORD
Set-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -Type DWord

# Install Chrome
$Path = $env:TEMP; 
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer

### Extract Zip 
Expand-Archive $destinationPath -DestinationPath $destinationFolder -Force

### Create Directories
New-Item -ItemType Directory -Force -Path C:\ -Name Data
New-Item -ItemType Directory -Force -Path C:\ -Name Log
New-Item -ItemType Directory -Force -Path C:\ -Name Migration

$spassword =  ConvertTo-SecureString "$password" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("$env:COMPUTERNAME\$user", $spassword)

Enable-PSRemoting -Force
Invoke-Command -Credential $credential -ComputerName $env:COMPUTERNAME -ArgumentList "Password", $spassword -ScriptBlock { 

		# Restore the database from the backup
        Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "RESTORE DATABASE CohoDW FROM DISK = 'C:\LabFiles\CohoDW.bak' WITH MOVE 'CohoDW_Data' TO 'C:\Data\CohoDW_Data.mdf', MOVE 'CohoDW_Log' TO 'C:\Log\CohoDW_Log.ldf'"

}
Disable-PSRemoting -Force
