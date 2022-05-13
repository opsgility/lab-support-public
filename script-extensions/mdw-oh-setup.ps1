# Optional - if we need to copy a file to the VM

$sourceFileUrl=""
$destinationFolder=""

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


# Install Chrome
$Path = $env:TEMP; 
$Installer = "ChromeSetup.exe"
Invoke-WebRequest "https://opsgilitylabs.blob.core.windows.net/public/ChromeSetup.exe" -OutFile $Path\$Installer
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

# Install SQL SSMS
$Path = $env:TEMP; 
$Installer = "SSMS-Setup-ENU.exe"
Write-Host "Downloading SSMS..." -ForegroundColor Green
Invoke-WebRequest "https://aka.ms/ssmsfullsetup" -OutFile $Path\$Installer
Write-Host "Installing SQL Server Management Studio from $Path\$Installer..." -ForegroundColor Green
Start-Process -FilePath $path\$installer -Args "/install /quiet /passive /norestart" -Verb RunAs -Wait


# Install VS Community


$Path = $env:TEMP; 
$Installer = "VisualStudioSetup.exe"
Write-Host "Downloading VS Community..." -ForegroundColor Green
Invoke-WebRequest "https://c2rsetup.officeapps.live.com/c2r/downloadVS.aspx?sku=community&channel=Release&version=VS2022&source=VSLandingPage&includeRecommended=true&cid=2030" -OutFile $Path\$Installer
Write-Host "Installing VS Community $Path\$Installer..." -ForegroundColor Green
Start-Process -FilePath $Path\$Installer -Args "--allworkloads -q" -Verb RunAs -Wait
#Remove-Item $Path\$Installer


Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name Az -Force -AllowClobber


# VS Code
$Path = $env:TEMP; 
$Installer = "vscode.exe"
Invoke-WebRequest "https://go.microsoft.com/fwlink/?Linkid=852157" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/verysilent /MERGETASKS=!runcode" -Verb RunAs -Wait
Remove-Item $Path\$Installer

# AZ Cli
$Path = $env:TEMP; 
$Installer = "cli_installer.msi"
Write-Host "Downloading Azure CLI 2..." -ForegroundColor Green
Invoke-WebRequest "https://aka.ms/InstallAzureCliWindows" -OutFile $Path\$Installer
Write-Host "Installing Azure CLI from $Path\$Installer..." -ForegroundColor Green
Start-Process -FilePath msiexec -Args "/i $Path\$Installer /quiet /qn /norestart" -Verb RunAs -Wait
Remove-Item $Path\$Installer

# Git
$Path = $env:TEMP; 
$Installer = "Git-2.21.0-64-bit.exe"
Write-Host "Downloading Git Client" -ForegroundColor Green
Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v2.21.0.windows.1/Git-2.21.0-64-bit.exe" -OutFile $Path\$Installer
Write-Host "Installing G from $Path\$Installer..." -ForegroundColor Green
Start-Process -FilePath $Path\$Installer -Args /VERYSILENT -Verb RunAs -Wait
#Remove-Item $Path\$Installer


# Create a PowerShell ISE Shortcut on the Desktop
$WshShell = New-Object -ComObject WScript.Shell
$allUsersDesktopPath = "$env:SystemDrive\Users\Public\Desktop"
New-Item -ItemType Directory -Force -Path $allUsersDesktopPath
$Shortcut = $WshShell.CreateShortcut("$allUsersDesktopPath\PowerShell ISE.lnk")
$Shortcut.TargetPath = "$env:windir\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
$Shortcut.Save()  
