# Disable IE ESC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer

# Download resources
$opsDir = "C:\OpsgilityTraining"

mkdir $opsDir
mkdir "$opsDir\Download"
cd $opsDir
$urlWindows2016 = "https://software-download.microsoft.com/download/pr/Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
$urlWindows2012R2 - "http://download.microsoft.com/download/6/2/A/62A76ABB-9990-4EFC-A4FE-C7D698DAEB96/9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO"
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

Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart