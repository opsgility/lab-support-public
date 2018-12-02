param($sourceFileUrl="", $destinationFolder="", $region="")
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

<#
$urlWindows2016 = "https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
$urlWindows2012R2 = "http://download.microsoft.com/download/6/2/A/62A76ABB-9990-4EFC-A4FE-C7D698DAEB96/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO"
$urlSQL = "https://go.microsoft.com/fwlink/?LinkID=853015"
$outputWindows2016 = "$opsDir\Download\Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
$outputWindows2012R2 = "$opsDir\Download\9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO"
$outputSQL = "$opsDir\Download\SQLServer2017-SSEI-Eval.exe"
#>
$urlSSMS = "https://go.microsoft.com/fwlink/?linkid=2014306"
$urlDMA = "https://download.microsoft.com/download/C/6/3/C63D8695-CEF2-43C3-AF0A-4989507E429B/DataMigrationAssistant.msi"
$outputSSMS = "$opsDir\Download\SSMS-Setup-ENU.exe"
$outputDMA = "$opsDir\Download\DataMigrationAssistant.msi"

Import-Module BitsTransfer
#Start-BitsTransfer -Source $urlWindows2016 -Destination $outputWindows2016
#Start-BitsTransfer -Source $urlWindows2012R2 -Destination $outputWindows2012R2
#Start-BitsTransfer -Source $urlSQL -Destination $outputSQL
Start-BitsTransfer -Source $urlSSMS -Destination $outputSSMS
Start-BitsTransfer -Source $urlDMA -Destination $outputDMA

# Format data disk
$disk = Get-Disk | ? { $_.PartitionStyle -eq "RAW" }
Initialize-Disk -Number $disk.DiskNumber -PartitionStyle GPT
New-Partition -DiskNumber $disk.DiskNumber -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel DATA


$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" ('C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Unrestricted -File ' + "C:\OpsgilityTraining\PostRebootConfigure.ps1")


switch($region)
{

    "WestUS"
    {
        $urlsmarthotelweb1 = "https://opsgilitylabs.blob.core.windows.net/public/SmartHotelWeb1.zip"
        $urlsmarthotelweb2 = "https://opsgilitylabs.blob.core.windows.net/public/SmartHotelWeb2.zip"
        $urlsmarthotelSQL1 = "https://opsgilitylabs.blob.core.windows.net/public/SmartHotelSQL1.zip"
    }
    "EastUS"
    {
        $urlsmarthotelweb1 = "https://opslabseastus.blob.core.windows.net/public/SmartHotelWeb1.zip"
        $urlsmarthotelweb2 = "https://opslabseastus.blob.core.windows.net/public/SmartHotelWeb2.zip"
        $urlsmarthotelSQL1 = "https://opslabseastus.blob.core.windows.net/public/SmartHotelSQL1.zip"
    }
    "SouthCentralUS"
    {
        $urlsmarthotelweb1 = "https://opslabssouthcentral.blob.core.windows.net/public/SmartHotelWeb1.zip"
        $urlsmarthotelweb2 = "https://opslabssouthcentral.blob.core.windows.net/public/SmartHotelWeb2.zip"
        $urlsmarthotelSQL1 = "https://opslabssouthcentral.blob.core.windows.net/public/SmartHotelSQL1.zip"
    }
    "NorthEurope"
    {
        $urlsmarthotelweb1 = "https://opslabsnortheurope.blob.core.windows.net/public/SmartHotelWeb1.zip"
        $urlsmarthotelweb2 = "https://opslabsnortheurope.blob.core.windows.net/public/SmartHotelWeb2.zip"
        $urlsmarthotelSQL1 = "https://opslabsnortheurope.blob.core.windows.net/public/SmartHotelSQL1.zip"
    }
    "WestEurope"
    {
        $urlsmarthotelweb1 = "https://opslabsnortheurope.blob.core.windows.net/public/SmartHotelWeb1.zip"
        $urlsmarthotelweb2 = "https://opslabsnortheurope.blob.core.windows.net/public/SmartHotelWeb2.zip"
        $urlsmarthotelSQL1 = "https://opslabsnortheurope.blob.core.windows.net/public/SmartHotelSQL1.zip"
    }
    "AustraliaEast"
    {
        $urlsmarthotelweb1 = "https://opslabsaustraliaeast.blob.core.windows.net/public/SmartHotelWeb1.zip"
        $urlsmarthotelweb2 = "https://opslabsaustraliaeast.blob.core.windows.net/public/SmartHotelWeb2.zip"
        $urlsmarthotelSQL1 = "https://opslabsaustraliaeast.blob.core.windows.net/public/SmartHotelSQL1.zip"
    }
    "EastAsia"
    {
        $urlsmarthotelweb1 = "https://opslabseastasia.blob.core.windows.net/public/SmartHotelWeb1.zip"
        $urlsmarthotelweb2 = "https://opslabseastasia.blob.core.windows.net/public/SmartHotelWeb2.zip"
        $urlsmarthotelSQL1 = "https://opslabseastasia.blob.core.windows.net/public/SmartHotelSQL1.zip"
    }

}


if ((Test-Path "D:\Temp") -eq $false)
{
    New-Item -Path "D:\Temp" -ItemType directory
}

$job1 = Start-BitsTransfer -Source $urlsmarthotelweb1 -Destination "D:\SmartHotelWeb1.zip" -Asynchronous
$job2 = Start-BitsTransfer -Source $urlsmarthotelweb2 -Destination "D:\SmartHotelWeb2.zip" -Asynchronous
$job3 = Start-BitsTransfer -Source $urlsmarthotelSQL1 -Destination "D:\SmartHotelSQL1.zip" -Asynchronous

$jobs = Get-BitsTransfer
while($true) {
    $complete = $true
    foreach($job in $jobs) {
        Write-Output "Status: " $job.JobState
        if($job.JobState -ne "Transferred") {
            Start-Sleep -Seconds 5
            $complete = $false
        }
    }

    if($complete -eq $true)
    {
      break
    }
    $jobs = Get-BitsTransfer

}

Complete-BitsTransfer -BitsJob $job1
Complete-BitsTransfer -BitsJob $job2
Complete-BitsTransfer -BitsJob $job



if ((Test-Path "F:\VirtualMachines") -eq $false)
{
    New-Item -Path "F:\VirtualMachines" -ItemType directory
}

$BackUpPath = "D:\SmartHotelWeb1.zip"
$Destination = "F:\VirtualMachines\"

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::ExtractToDirectory($BackUpPath, $destination)


(new-object -com shell.application).namespace("F:\VirtualMachines").CopyHere((new-object -com shell.application).namespace("D:\SmartHotelWeb1.zip").Items(),16)
(new-object -com shell.application).namespace("F:\VirtualMachines").CopyHere((new-object -com shell.application).namespace("D:\SmartHotelWeb2.zip").Items(),16)
(new-object -com shell.application).namespace("F:\VirtualMachines").CopyHere((new-object -com shell.application).namespace("D:\SmartHotelSQL1.zip").Items(),16)


Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart