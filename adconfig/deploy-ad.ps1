$domain="adatum.com"
$password="demo@pass123"

Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature

Install-WindowsFeature -Name DNS -IncludeManagementTools

Install-ADDSForest -DomainName $domain `
                   -DomainMode WinThreshold `
                   -ForestMode WinThreshold `
                   -Force `
                   -SafeModeAdministratorPassword $smPassword
