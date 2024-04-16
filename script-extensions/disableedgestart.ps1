# Kill Edge start 
New-Item "HKCU:\SOFTWARE\Policies\Microsoft\MicrosoftEdge"
New-Item "HKCU:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main"  
$path2 = "HKCU:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" 
New-ItemProperty -Path $path2 -Name "PreventFirstRunPage" -Value 1


# Create a Edge Shortcut on the Desktop
$WshShell = New-Object -ComObject WScript.Shell
$allUsersDesktopPath = "$env:SystemDrive\Users\Public\Desktop"
New-Item -ItemType Directory -Force -Path $allUsersDesktopPath
$Shortcut = $WshShell.CreateShortcut("$allUsersDesktopPath\Microsoft Edge.lnk")
$Shortcut.TargetPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$Shortcut.Save()  