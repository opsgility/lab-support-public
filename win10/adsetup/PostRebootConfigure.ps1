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
}

Process {
    
# Download post-migration conteent files
Write-Output "Downloading zip file..."
$sourceFileUrl = "$repo/$ContentFile"
$fileName = Split-Path -Path $sourceFileUrl -Leaf
$destinationPath = Join-Path $destinationFolder $fileName

(New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);

Write-Output "Extracting zip to $destinationFolder..."
(new-object -com shell.application).namespace($destinationFolder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)

&"$Folder\StudentFiles\DomainUpdate.ps1" -SharePath "$Folder\StudentFiles\LabFiles"


}

End {
    Stop-Transcript
}
