$ErrorActionPreference = 'SilentlyContinue'

# Disable IE ESC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer

# Install Chrome
$Path = $env:TEMP; 
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer

# Create path
$opsDir = "C:\OpsgilityTraining"
New-Item -Path $opsDir -ItemType directory -Force

# Format data disk
$disk = Get-Disk | ? { $_.PartitionStyle -eq "RAW" }
Initialize-Disk -Number $disk.DiskNumber -PartitionStyle GPT
New-Partition -DiskNumber $disk.DiskNumber -UseMaximumSize -DriveLetter F
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel DATA

# Download disks for nested Hyper-V VMs, and various other files we'll need during the lab
$downloads = @( `
     "https://cloudworkshop.blob.core.windows.net/azure-migration/PostRebootConfigure.ps1" `
    ,"https://cloudworkshop.blob.core.windows.net/azure-migration/OnLoginConfigure.ps1" `
    ,"https://cloudworkshop.blob.core.windows.net/azure-migration/ConfigureAzureMigrateApplianceNetwork.ps1" `
    ,"https://download.microsoft.com/download/C/6/3/C63D8695-CEF2-43C3-AF0A-4989507E429B/DataMigrationAssistant.msi" `
    )

$destinationFiles = @( `
     "$opsDir\PostRebootConfigure.ps1" `
    ,"$opsDir\OnLoginConfigure.ps1" `
    ,"$opsDir\ConfigureAzureMigrateApplianceNetwork.ps1" `
    ,"$opsDir\DataMigrationAssistant.msi" `
    )

Import-Module BitsTransfer
Start-BitsTransfer -Source $downloads -Destination $destinationFiles

# Register task to run post-reboot script once host is rebooted after Hyper-V install
$action = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe" -Argument "-executionPolicy Unrestricted -File $opsDir\PostRebootConfigure.ps1"
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName "SetUpVMs" -Action $action -Trigger $trigger -Principal $principal

# Install and configure DHCP service (used by Azure Migrate appliance so DNS lookup of 'SmartHotelHost' works)
$dnsClient = Get-DnsClient | Where-Object {$_.InterfaceAlias -eq "Ethernet" }
Install-WindowsFeature -Name "DHCP" -IncludeManagementTools
Add-DhcpServerv4Scope -Name "Migrate" -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -State Active
Add-DhcpServerv4ExclusionRange -ScopeID 192.168.1.0 -StartRange 192.168.1.1 -EndRange 192.168.1.15
Set-DhcpServerv4OptionValue -DnsDomain $dnsClient.ConnectionSpecificSuffix -DnsServer 168.63.129.16
Set-DhcpServerv4OptionValue -OptionID 3 -Value 192.168.1.1 -ScopeID 192.168.1.0
Set-DhcpServerv4Scope -ScopeId 192.168.1.0 -LeaseDuration 1.00:00:00
Restart-Service dhcpserver

# Install Hyper-V and reboot
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart