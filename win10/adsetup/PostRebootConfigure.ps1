param(
    [string]$domain="opsaaddemo.local",
    [string]$repo="https://github.com/KitSkin/publabs/raw/master/win10ad",
    [string]$Folder="C:\OpsgilityTraining",
    [string]$cmdLogPath
    )

Begin {
    Start-Transcript "C:\PostRebootConfigure_log.txt"
    $cmdLogPath = "C:\PostRebootConfigure_log_cmd.txt"

    Function Expand-Files {
        [cmdletbinding()]
        Param (
            [parameter(ValueFromPipeline=$true)]
            [Object[]]$Files,
            [string]$Destination
        )
    
        foreach ($file in $files)
        {
            $fileName = $file.FullName
            $fileBase = $file.BaseName
            $null=mkdir "$Destination\$fileBase" -ErrorAction SilentlyContinue
    
            write-output "Start unzip: $fileName to $Destination"
            
            $7zEXE = "$Folder\7z\7za.exe"
    
            cmd /c "$7zEXE x -y -o$Destination\$fileBase $fileName" | Add-Content $cmdLogPath
            
            write-output "Finish unzip: $fileName to $Destination"
        }
    }
}

Process {
    
# Download post-migration conteent files
Write-Output "Download with Bits"
$sourceFolder = "$repo/support"
$downloads = @(
    "$sourceFolder/StudentFiles.zip"
)
$destinationFiles = @(
    "$Folder\StudentFiles.zip"
)

Import-Module BitsTransfer
0..($downloads.Length-1) | %{
    Write-Host "Download $($downloads[$_]) to $($destinationFiles[$_])..."
    Start-BitsTransfer -Source $downloads[$_] -Destination $destinationFiles[$_]
}

# extract content
$FileItems = $destinationFiles | Get-Item
$FileItems | Expand-Files -Destination $Folder

&"$Folder\StudentFiles\DomainUpdate.ps1" -SharePath "$Folder\StudentFiles\LabFiles"


}

End {
    Stop-Transcript
}
