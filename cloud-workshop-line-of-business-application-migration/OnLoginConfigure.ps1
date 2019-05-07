Function Wait-For-Website {
    Param (
        [string]$Url
    )

    $i = 1
    while ($true) {

        try {
            Write-Output "Checking ($i)...please wait"
            $i++

            $response = Invoke-WebRequest -Uri $Url -TimeoutSec 10 -UseBasicParsing
            if ($response.StatusCode -eq 200) {
                return;
            }
        } catch {}

        Start-Sleep 2
    }
}

# Wait until website is up, so we know PostRebootConfigure script has finished
Write-Output "Checking SmartHotel provisioning"
Wait-For-Website('http://192.168.0.8')

# Rearm (extend evaluation license) and reboot each Windows VM
Write-Output "Configuring VMs..."
$localusername = "Administrator"
$password = ConvertTo-SecureString "demo@pass123" -AsPlainText -Force
$localcredential = New-Object System.Management.Automation.PSCredential ($localusername, $password)

for ($i = 4; $i -le 6; $i++) {
    Write-Output "Configuring VM at 192.168.0.$i..."
    set-item wsman:\localhost\Client\TrustedHosts -value "192.168.0.$i" -Force
    Invoke-Command -ComputerName "192.168.0.$i" -ScriptBlock { 
        slmgr.vbs /rearm
        net accounts /maxpwage:unlimited
        Restart-Computer -Force
    } -Credential $localcredential
    Write-Output "Configuration complete"
}

# Warm up the app after the reboot
Write-Output "Waiting for SmartHotel reboot"
Wait-For-Website('http://192.168.0.8')