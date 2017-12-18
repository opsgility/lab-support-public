# Required - other wise RDP won't connect from inside RDS VMs
$stupidKeyToDeleteParent = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

Get-ChildItem -Path $stupidKeyToDeleteParent | foreach {
    $keyName = Split-Path $_ -Leaf
    if($keyName.Length -gt 12) # skip the short ones 
    {
        $stupidKeyToDelete = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$keyName"
        $stupidKeyToDelete
        Remove-Item -Path $stupidKeyToDelete -Force
    }
}
