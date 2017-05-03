### Install Windows Failover Clustering
Install-WindowsFeature -Name "Failover-Clustering" `
                       -IncludeManagementTools `
                       -IncludeAllSubFeature

### Disable domain firewall
Set-NetFirewallProfile -Profile Domain -Enabled False

### Enable File and Printer Sharing
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Domain

### Enable Network Discovery
# Turn on SSDPSRV
Set-Service SSDPSRV -startupType Automatic
Start-Service SSDPSRV
# Turn on Dnscache
Set-Service Dnscache -startupType Automatic
Start-Service Dnscache
# Turn on upnphost
Set-Service upnphost -startupType Automatic
Start-Service upnphost
# Enable Network Discovery
Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Profile Domain

### Disable IE Enhanced Security
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

#Join Domain
$user = "demouser"
$password = "Demo@pass123"
$domain = "contoso.com"
$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)

$domainUser = "$domain\$user"
$cred = new-object -typename System.Management.Automation.PSCredential `
         -argumentlist $domainUser, $smPassword

Add-Computer -DomainName $domain -Credential $cred -Restart