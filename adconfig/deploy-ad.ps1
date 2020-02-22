$domain="adatum.com"
$password="Pa55w.rd"

Install-WindowsFeature -Name "AD-Domain-Services" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature

Install-WindowsFeature -Name DNS -IncludeManagementTools

Install-ADDSForest -DomainName $domain `
                   -DomainMode WinThreshold `
                   -ForestMode WinThreshold `
                   -Force `
                   -SafeModeAdministratorPassword $smPassword
