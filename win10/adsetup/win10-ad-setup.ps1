param($domain,
    $password,
    $sourceRepo="https://raw.githubusercontent.com/opsgility/lab-support-public/master/win10/adsetup",
    $destinationFolder="C:\SkillMeUp",
    $postConfig="PostRebootConfigure.ps1")

$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)

# Create folder for download and post run scripts
New-Item -Path "$destinationFolder" -ItemType Directory -Force

# Download post-migration script
Write-host "Downloading post config script"
$sourceFileUrl = "$sourceRepo/$postConfig"
$FileName = Split-Path $postConfig -Leaf
$destinationPath = "$destinationFolder\$FileName"
(New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);

# (new-object -com shell.application).namespace($destinationFolder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)

# Register task to run post-reboot script once host is rebooted after Hyper-V install
Write-Output "Register post-reboot script as scheduled task"
$action = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe" -Argument "-executionPolicy Unrestricted -File ""$destinationPath"" -Domain $domain -repo $sourceRepo -Folder ""$destinationFolder"""
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName "SetUpDC" -Action $action -Trigger $trigger -Principal $principal

# AD DS deployment
# derived from script-extensions/deploy-ad.ps1
Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature 

Install-ADDSForest -DomainName $domain `
                   -DomainMode Win2012R2 `
                   -ForestMode Win2012R2 `
                   -Force `
                   -SafeModeAdministratorPassword $smPassword 

