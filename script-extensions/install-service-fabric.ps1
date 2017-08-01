Set-Location d:

mkdir temp

Set-Location temp

$webclient = New-Object System.Net.WebClient

$webclient.DownloadFile("https://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi", "d:\temp\wpi.msi")

d:\temp\wpi.msi /quiet

$wpidir = "C:\Program Files\Microsoft\Web Platform Installer"

Start-Process WebpiCmd.exe '/Install /Products:"Microsoft Azure Service Fabric SDK - 2.6.220" /AcceptEula /Log:"d:\temp\wpi-log.txt"' -Wait -WorkingDirectory $wpidir -RedirectStandardError -Credential demouser
