param($sourceFileUrl="", $destinationFolder="", $labName="Ignored",$installOptions="Chrome")
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

if ([string]::IsNullOrEmpty($installOptions) -eq $false) 
{
    if ($installOptions.Contains("Chrome")) 
    {
        # Install Chrome
        $Path = $env:TEMP; 
        $Installer = "chrome_installer.exe"
        Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
        Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
        Remove-Item $Path\$Installer
    }

    if ($installOptions.Contains("VSCode")) 
    {
        # Install VS Code
        $Path = $env:TEMP; 
        $Installer = "vscode.exe"
        Invoke-WebRequest "https://go.microsoft.com/fwlink/?Linkid=852157" -OutFile $Path\$Installer
        Start-Process -FilePath $Path\$Installer -Args "/verysilent /MERGETASKS=!runcode" -Verb RunAs -Wait
        Remove-Item $Path\$Installer
    }

    if ($installOptions.Contains("CLI")) 
    {
        # Install Azure CLI 2
        $Path = $env:TEMP; 
        $Installer = "cli_installer.msi"
        Write-Host "Downloading Azure CLI 2..." -ForegroundColor Green
        Invoke-WebRequest "https://aka.ms/InstallAzureCliWindows" -OutFile $Path\$Installer
        Write-Host "Installing Azure CLI from $Path\$Installer..." -ForegroundColor Green
        Start-Process -FilePath msiexec -Args "/i $Path\$Installer /quiet /qn /norestart" -Verb RunAs -Wait
        Remove-Item $Path\$Installer
    }

}

# Create a PowerShell ISE Shortcut on the Desktop
$WshShell = New-Object -ComObject WScript.Shell
$allUsersDesktopPath = "$env:SystemDrive\Users\Public\Desktop"
New-Item -ItemType Directory -Force -Path $allUsersDesktopPath
$Shortcut = $WshShell.CreateShortcut("$allUsersDesktopPath\PowerShell ISE.lnk")
$Shortcut.TargetPath = "$env:windir\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
$Shortcut.Save()  

# Download resources
$opsDir = "C:\OpsgilityTraining"

if ((Test-Path $opsDir) -eq $false)
{
    New-Item -Path $opsDir -ItemType directory
    New-Item -Path "$opsDir\Download" -ItemType directory
}

if ((Test-Path "$opsDir\Download") -eq $false)
{
    New-Item -Path "$opsDir\Download" -ItemType directory
}

Import-Module BitsTransfer

# Download CentOS
$urlCentOS7DVD = "http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1804.iso"
$outputCentOS7DVD = "$opsDir\Download\CentOS-7-x86_64-DVD-1804.iso"
Start-BitsTransfer -Source $urlCentOS7DVD -Destination $outputCentOS7DVD

# Download RHEL6
$urlrhel6DVD = "https://opsgilitylabs.blob.core.windows.net/online-labs/migrating-hyperv-linux-vm-to-azure/rhel-server-6.10-x86_64-dvd.iso"
$outputrhel6DVD = "$opsDir\Download\rhel-server-6.10-x86_64-dvd.iso"
Start-BitsTransfer -Source $urlrhel6DVD -Destination $outputrhel6DVD

# Download RHEL7
$urlrhel7DVD = "https://opsgilitylabs.blob.core.windows.net/online-labs/migrating-hyperv-linux-vm-to-azure/rhel-server-7.6-x86_64-dvd.iso"
$outputrhel7DVD = "$opsDir\Download\rhel-server-7.6-x86_64-dvd.iso"
Start-BitsTransfer -Source $urlrhel7DVD -Destination $outputrhel7DVD

Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart
