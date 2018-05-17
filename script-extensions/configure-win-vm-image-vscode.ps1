param($sourceFileUrl="", $destinationFolder="", $labName="")
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

# Allow file downloads
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
Set-ItemProperty -Path $HKLM -Name "1807" -Value 0
Set-ItemProperty -Path $HKCU -Name "1807" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
Set-ItemProperty -Path $HKLM -Name "1807" -Value 0
Set-ItemProperty -Path $HKCU -Name "1807" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
Set-ItemProperty -Path $HKLM -Name "1807" -Value 0
Set-ItemProperty -Path $HKCU -Name "1807" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
Set-ItemProperty -Path $HKLM -Name "1807" -Value 0
Set-ItemProperty -Path $HKCU -Name "1807" -Value 0

# allow websites to open windows without address or status bars 
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
Set-ItemProperty -Path $HKLM -Name "2104" -Value 0
Set-ItemProperty -Path $HKCU -Name "2104" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
Set-ItemProperty -Path $HKLM -Name "2104" -Value 0
Set-ItemProperty -Path $HKCU -Name "2104" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
Set-ItemProperty -Path $HKLM -Name "2104" -Value 0
Set-ItemProperty -Path $HKCU -Name "2104" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
Set-ItemProperty -Path $HKLM -Name "2104" -Value 0
Set-ItemProperty -Path $HKCU -Name "2104" -Value 0

$HKLM = "HKLM:\Software\Microsoft\Internet Explorer\Security"
New-ItemProperty -Path $HKLM -Name "DisableSecuritySettingsCheck" -Value 1 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "DisableSecuritySettingsCheck" -Value 1
Stop-Process -Name Explorer
Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green

# Allow programmatic clipboard access
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
Set-ItemProperty -Path $HKLM -Name "1407" -Value 0
Set-ItemProperty -Path $HKCU -Name "1407" -Value 0

# Emulate IE 11 for web browser control
$HKLM = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"
New-ItemProperty -Path $HKLM -Name "opsgility.exe" -Value 11001 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "opsgility.exe" -Value 11001 -Type DWord

# Turn off server manager on load
$HKLM = "HKLM:\SOFTWARE\Microsoft\ServerManager"
New-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 0 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 0 -Type DWord

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
    # Copy shortcut to desktopgit
    Copy-Item -Path $shortCutPath -Destination "C:\Users\Default\Desktop"
}

# Install Chrome
$Path = $env:TEMP; 
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer


# Install VS Code
$Path = $env:TEMP; 
$Installer = "vscode.exe"
Invoke-WebRequest "https://go.microsoft.com/fwlink/?Linkid=852157" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/verysilent /MERGETASKS=!runcode" -Verb RunAs -Wait
Remove-Item $Path\$Installer


# Install Azure CLI 2
$Path = $env:TEMP; 
$Installer = "cli_installer.msi"
Write-Host "Downloading Azure CLI 2..." -ForegroundColor Green
Invoke-WebRequest "https://aka.ms/InstallAzureCliWindows" -OutFile $Path\$Installer
Write-Host "Installing Azure CLI from $Path\$Installer..." -ForegroundColor Green
Start-Process -FilePath msiexec -Args "/i $Path\$Installer /quiet /qn /norestart" -Verb RunAs -Wait
Remove-Item $Path\$Installer




