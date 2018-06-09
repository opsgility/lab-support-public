param($sourceFileUrl="", $destinationFolder="", $labName="", $Username="__administrator")
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


Stop-Process -Name Explorer
Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green

# Hide Server Manager
$HKLM = "HKLM:\SOFTWARE\Microsoft\ServerManager"
New-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -Type DWord

# Hide Server Manager
$HKCU = "HKEY_CURRENT_USER\Software\Microsoft\ServerManager"
New-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -PropertyType DWORD
Set-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -Type DWord



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

# Create a PowerShell ISE Shortcut on the Desktop
$WshShell = New-Object -ComObject WScript.Shell
$allUsersDesktopPath = "$env:SystemDrive\Users\Public\Desktop"
New-Item -ItemType Directory -Force -Path $allUsersDesktopPath
$Shortcut = $WshShell.CreateShortcut("$allUsersDesktopPath\PowerShell ISE.lnk")
$Shortcut.TargetPath = "$env:windir\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
$Shortcut.Save()  


# Configure Azure Stack Pre-Reqs

function DownloadWithRetry([string] $Uri, [string] $DownloadLocation, [int] $Retries = 5, [int]$RetryInterval = 10)
{
    while($true)
    {
        try
        {
            Start-BitsTransfer -Source $Uri -Destination $DownloadLocation -DisplayName $Uri
            break
        }
        catch
        {
            $exceptionMessage = $_.Exception.Message
            Write-Host "Failed to download '$Uri': $exceptionMessage"
            if ($retries -gt 0) {
                $retries--
                Write-Host "Waiting $RetryInterval seconds before retrying. Retries left: $Retries"
                Clear-DnsClientCache
                Start-Sleep -Seconds $RetryInterval
 
            }
            else
            {
                $exception = $_.Exception
                throw $exception
            }
        }
    }
}

$defaultLocalPath = "C:\AzureStackOnAzureVM"
New-Item -Path $defaultLocalPath -ItemType Directory -Force

DownloadWithRetry -Uri "https://raw.githubusercontent.com/yagmurs/AzureStack-VM-PoC/development/config.ind" -DownloadLocation "$defaultLocalPath\config.ind"
#Invoke-WebRequest -Uri "https://raw.githubusercontent.com/yagmurs/AzureStack-VM-PoC/development/config.ind" -OutFile "$defaultLocalPath\config.ind"
$gitbranchconfig = Import-Csv -Path $defaultLocalPath\config.ind -Delimiter ","
$gitbranchcode = $gitbranchconfig.branch.Trim()
$gitbranch = "https://raw.githubusercontent.com/yagmurs/AzureStack-VM-PoC/$gitbranchcode"

DownloadWithRetry -Uri "$gitbranch/scripts/ASDKHelperModule.psm1" -DownloadLocation "$defaultLocalPath\ASDKHelperModule.psm1"

if (Test-Path "$defaultLocalPath\ASDKHelperModule.psm1")
{
    Import-Module "$defaultLocalPath\ASDKHelperModule.psm1"
}
else
{
    throw "required module $defaultLocalPath\ASDKHelperModule.psm1 not found"   
}

#Disables Internet Explorer Enhanced Security Configuration
Disable-InternetExplorerESC

#Enable Internet Explorer File download
New-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' -Name 1803 -Value 0 -Force
New-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0' -Name 1803 -Value 0 -Force

New-Item HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials -Force
New-Item HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly -Force
Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials -Name 1 -Value "wsman/*" -Type STRING -Force
Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly -Name 1 -Value "wsman/*" -Type STRING -Force
Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name AllowFreshCredentials -Value 1 -Type DWORD -Force
Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name AllowFreshCredentialsWhenNTLMOnly -Value 1 -Type DWORD -Force
Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name ConcatenateDefaults_AllowFresh -Value 1 -Type DWORD -Force
Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name ConcatenateDefaults_AllowFreshNTLMOnly -Value 1 -Type DWORD -Force
Set-Item -Force WSMan:\localhost\Client\TrustedHosts "*"
Enable-WSManCredSSP -Role Client -DelegateComputer "*" -Force
Enable-WSManCredSSP -Role Server -Force

#Enable Long path support to workaround ASDK 1802 installation issues on common/helper.psm1 
#https://msdn.microsoft.com/en-us/library/aa365247%28VS.85%29.aspx?f=255&MSPPError=-2147217396#maxpath
#Set-ItemProperty -LiteralPath HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name LongPathsEnabled -Value 1 -Type DWORD -Force

Add-WindowsFeature RSAT-AD-PowerShell, RSAT-ADDS -IncludeAllSubFeature

Install-PackageProvider nuget -Force

Rename-LocalUser -Name $username -NewName Administrator

Set-ExecutionPolicy unrestricted -Force

#Download Install-ASDK.ps1 (installer)
DownloadWithRetry -Uri "$gitbranch/scripts/Install-ASDK.ps1" -DownloadLocation "$defaultLocalPath\Install-ASDK.ps1"
#Invoke-WebRequest -Uri "$gitbranch/scripts/Install-ASDK.ps1" -OutFile "$defaultLocalPath\Install-ASDK.ps1"

#Download ASDK Downloader
DownloadWithRetry -Uri "https://aka.ms/azurestackdevkitdownloader" -DownloadLocation "D:\AzureStackDownloader.exe"
#Invoke-WebRequest -Uri "https://aka.ms/azurestackdevkitdownloader" -OutFile "D:\AzureStackDownloader.exe"

#Download and extract Mobaxterm
DownloadWithRetry -Uri "https://aka.ms/mobaxtermLatest" -DownloadLocation "$defaultLocalPath\Mobaxterm.zip"
#Invoke-WebRequest -Uri "https://aka.ms/mobaxtermLatest" -OutFile "$defaultLocalPath\Mobaxterm.zip"
Expand-Archive -Path "$defaultLocalPath\Mobaxterm.zip" -DestinationPath "$defaultLocalPath\Mobaxterm"
Remove-Item -Path "$defaultLocalPath\Mobaxterm.zip" -Force

#Creating desktop shortcut for Install-ASDK.ps1
New-Item -ItemType SymbolicLink -Path ($env:ALLUSERSPROFILE + "\Desktop") -Name "Install-ASDK" -Value "$defaultLocalPath\Install-ASDK.ps1"

Add-WindowsFeature Hyper-V, Failover-Clustering, Web-Server -IncludeManagementTools -Restart