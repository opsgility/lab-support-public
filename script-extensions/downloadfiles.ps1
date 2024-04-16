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

# Kill Edge start 
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge"
New-Item "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main"  
$path2 = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" 
New-ItemProperty -Path $path2 -Name "PreventFirstRunPage" -Value 1


# Create a Edge Shortcut on the Desktop
$WshShell = New-Object -ComObject WScript.Shell
$allUsersDesktopPath = "$env:SystemDrive\Users\Public\Desktop"
New-Item -ItemType Directory -Force -Path $allUsersDesktopPath
$Shortcut = $WshShell.CreateShortcut("$allUsersDesktopPath\Microsoft Edge.lnk")
$Shortcut.TargetPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$Shortcut.Save()  