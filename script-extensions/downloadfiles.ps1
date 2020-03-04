param($sourceFileUrl="", $destinationFolder="")

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


$path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Privacy\"


if((Test-Path -Path $path) -eq $true)
{
    Set-ItemProperty -Path $path -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0
}


$opsDir = "C:\SkillMeUp"

if((Test-Path -Path $opsDir) -eq $false)
{
    New-Item -Path $opsDir -ItemType directory -Force
}

# Download scripts
Write-Output "Download scripts"
$downloads = @( `
     "https://raw.githubusercontent.com/opsgility/lab-support-public/master/win10/no-personalized-experience.ps1" 
    )

$destinationFiles = @( `
     "$opsDir\no-personalized-experience.ps1" `
    )

Import-Module BitsTransfer
Start-BitsTransfer -Source $downloads -Destination $destinationFiles

# Register task to run post-reboot script once host is rebooted after Hyper-V install
Write-Output "Register post-reboot script as scheduled task"
$action = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe" -Argument "-executionPolicy Unrestricted -File $opsDir\no-personalized-experience.ps1"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName "SetUpVMs" -Action $action -Trigger $trigger -Principal $principal