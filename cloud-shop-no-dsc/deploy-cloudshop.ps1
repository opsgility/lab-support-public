param($cloudShopUrl)



add-WindowsFeature -Name "Web-Server" -IncludeAllSubFeature




$splitpath = $cloudShopUrl.Split("/")

$fileName = $splitpath[$splitpath.Length-1]

$destinationPath = "C:\Inetpub\wwwroot\CloudShop.zip"

$destinationFolder = "C:\Inetpub\wwwroot"



$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($cloudShopUrl,$destinationPath)



(new-object -com shell.application).namespace($destinationFolder).CopyHere((new-object -com shell.application).namespace($destinationPath).Items(),16)




