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

