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

Stop-Process -Name Explorer
Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green


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




