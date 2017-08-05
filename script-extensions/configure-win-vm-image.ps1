param($sourceFileUrl, $destinationFolder)
$ErrorActionPreference = 'SilentlyContinue'



if([string]::IsNullOrEmpty($sourceFileUrl) -eq $false -and [string]::IsNullOrEmpty($destinationFolder -eq $false))
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



# Disable IE Enhanced Security Configuration
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"

New-Item -Path $adminKey -Force
New-Item -Path $UserKey -Force
New-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
New-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
$HKCU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4"
Set-ItemProperty -Path $HKLM -Name "1803" -Value 0
Set-ItemProperty -Path $HKCU -Name "1803" -Value 0
$HKLM = "HKLM:\Software\Microsoft\Internet Explorer\Security"
New-ItemProperty -Path $HKLM -Name "DisableSecuritySettingsCheck" -Value 1 -PropertyType DWORD

Stop-Process -Name Explorer
Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green


