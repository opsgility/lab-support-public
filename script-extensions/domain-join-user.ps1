param($domain, $user="demouser", $password)
$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)
$user = "$domain\$user"
$objCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($user, $smPassword)
Add-Computer -DomainName "$domain" -Credential $objCred -Restart -Force