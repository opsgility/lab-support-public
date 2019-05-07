# Connect Azure Migrate switch to the NAT network
$adapter = Get-NetAdapter | ? { $_.Name -like "*Migrate*" }
New-NetIPAddress -IPAddress 192.168.1.1 -PrefixLength 24 -InterfaceIndex $adapter.ifIndex
