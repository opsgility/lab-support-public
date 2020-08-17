param($domain, $user, $password)
$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)
$user = "$domain\demouser"
$objCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($user, $smPassword)
Add-Computer -DomainName "$domain" -Credential $objCred -Restart -Force