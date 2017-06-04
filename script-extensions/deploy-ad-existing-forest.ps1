param($domain, $password)

$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)

Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature 


Install-ADDSDomainController -DomainName $domain `
                   -SafeModeAdministratorPassword $smPassword `
                   -InstallDNS $true

