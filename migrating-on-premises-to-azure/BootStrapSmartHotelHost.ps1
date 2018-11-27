param($sourceFileUrl="", $destinationFolder="")
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

# Install Chrome
$Path = $env:TEMP; 
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer

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

Set-Location $opsDir
$urlWindows2016 = "https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
$urlWindows2012R2 = "http://download.microsoft.com/download/6/2/A/62A76ABB-9990-4EFC-A4FE-C7D698DAEB96/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO"
$urlSQL = "https://go.microsoft.com/fwlink/?LinkID=853015"
$urlSSMS = "https://go.microsoft.com/fwlink/?linkid=2014306"
$urlDMA = "https://download.microsoft.com/download/C/6/3/C63D8695-CEF2-43C3-AF0A-4989507E429B/DataMigrationAssistant.msi"
$outputWindows2016 = "$opsDir\Download\Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
$outputWindows2012R2 = "$opsDir\Download\9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO"
$outputSQL = "$opsDir\Download\SQLServer2017-SSEI-Eval.exe"
$outputSSMS = "$opsDir\Download\SSMS-Setup-ENU.exe"
$outputDMA = "$opsDir\Download\DataMigrationAssistant.msi"

Import-Module BitsTransfer
Start-BitsTransfer -Source $urlWindows2016 -Destination $outputWindows2016
Start-BitsTransfer -Source $urlWindows2012R2 -Destination $outputWindows2012R2
Start-BitsTransfer -Source $urlSQL -Destination $outputSQL
Start-BitsTransfer -Source $urlSSMS -Destination $outputSSMS
Start-BitsTransfer -Source $urlDMA -Destination $outputDMA

# Format data disk
$disk = Get-Disk | ? { $_.PartitionStyle -eq "RAW" }
Initialize-Disk -Number $disk.DiskNumber -PartitionStyle GPT
New-Partition -DiskNumber $disk.DiskNumber -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel DATA

$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "C:\OpsgilityTraining\PostRebootConfigure.ps1")


Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart