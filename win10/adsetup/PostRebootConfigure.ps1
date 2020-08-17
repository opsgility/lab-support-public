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

$maxTries=15
$waitInSeconds=45
$try=0
Do {
    try {
        (New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);
    } catch {
        If (-not (Test-Path $destinationPath -ErrorAction SilentlyContinue)) {
            Write-Error "Could not download $sourceFileUrl . Pausing for $waitInSeconds seconds before trying again."
            Start-Sleep -Seconds $waitInSeconds
        } else {
            throw $Error[0]
        }
    }

    $try++
} Until ($try -ge $maxTries -or (Test-Path $destinationPath -ErrorAction SilentlyContinue))

If (Test-Path $destinationPath -ErrorAction SilentlyContinue) {
    Write-Output "Extracting zip to $Folder..."
    (new-object -com shell.application).namespace($Folder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)

    try {
        &"$Folder\DomainUpdate.ps1" -SharePath "$Folder\LabFiles"
    } catch {
        Write-Error "Could not complete Domain Update.  Pausing 10 minutes for Domain Services to start and attempting again."
        Start-Sleep -Seconds 600
        &"$Folder\DomainUpdate.ps1" -SharePath "$Folder\LabFiles"
    }
} else {
    Write-Error "Unable to download file.  Reboot to attempt to download again."
}

}

End {
    Stop-Transcript
}
