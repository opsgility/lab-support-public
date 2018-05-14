# Download RDP fix 
$url = "https://opsgilitylabs.blob.core.windows.net/rdp-fix/windows10.0-kb4093120-x64_72c7d6ce20eb42c0df760cd13a917bbc1e57c0b7.msu"
$output = "C:\OpsgilityTraining\windows10.0-kb4093120-x64_72c7d6ce20eb42c0df760cd13a917bbc1e57c0b7.msu"

if((Test-Path -Path "C:\OpsgilityTraining") -eq $false) {

    New-Item -Path "C:\OpsgilityTraining" -ItemType Directory
}
Invoke-WebRequest -Uri $url -OutFile $output


& wusa.exe C:\OpsgilityTraining\windows10.0-kb4093120-x64_72c7d6ce20eb42c0df760cd13a917bbc1e57c0b7.msu /quiet /forcerestart
