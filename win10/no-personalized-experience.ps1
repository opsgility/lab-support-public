$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy\"
if((Test-Path -Path $path) -eq $true)
{
    Set-ItemProperty -Path $path -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0
}