param($sourceFileUrl, $destinationFolder)


if((Test-Path $destinationFolder) -eq $false)
{
    New-Item -Path $destinationFolder -ItemType directory
}

if($sourceFileUrl -ne "" -and $sourceFileUrl -ne $null -and $destinationFolder -ne "" -and $destinationFolder -ne $null)
{
$splitpath = $sourceFileUrl.Split("/")
$fileName = $splitpath[$splitpath.Length-1]
$destinationPath = Join-Path $destinationFolder $fileName

(New-Object Net.WebClient).DownloadFile($sourceFileUrl,$destinationPath);

(new-object -com shell.application).namespace($destinationFolder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)
}



# Disable IE Enhanced Security Configuration
$AdminKey = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}”
$UserKey = “HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}”

New-Item -Path $adminKey -Force
New-Item -Path $UserKey -Force
New-ItemProperty -Path $AdminKey -Name “IsInstalled” -Value 0
New-ItemProperty -Path $UserKey -Name “IsInstalled” -Value 0
Stop-Process -Name Explorer
Write-Host “IE Enhanced Security Configuration (ESC) has been disabled.” -ForegroundColor Green
