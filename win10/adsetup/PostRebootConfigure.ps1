param(
    [string]$domain="opsaaddemo.local",
    [string]$repo="https://raw.githubusercontent.com/opsgility/lab-support-public/master/win10/adsetup",
    [string]$Folder="C:\SkillMeUp",
    [string]$ContentFile="StudentFiles.zip",
    [string]$cmdLogPath
    )

Begin {
    Start-Transcript "C:\PostRebootConfigure_log.txt"
    $cmdLogPath = "C:\PostRebootConfigure_log_cmd.txt"
    If (-not (Test-Path $Folder -ErrorAction SilentlyContinue)) { mkdir $Folder }
}

Process {
    
# Download post-migration conteent files
Write-Output "Downloading zip file..."
$sourceFileUrl = "$repo/$ContentFile"
$fileName = Split-Path -Path $sourceFileUrl -Leaf
$destinationPath = Join-Path $Folder $fileName

(New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);

Write-Output "Extracting zip to $Folder..."
(new-object -com shell.application).namespace($Folder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)

&"$Folder\DomainUpdate.ps1" -SharePath "$Folder\LabFiles"


}

End {
    Stop-Transcript
}
