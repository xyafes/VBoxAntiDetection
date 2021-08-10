param (
	[switch]$all = $false,
	[switch]$reg = $false,
	[switch]$procs = $false,
	[switch]$files = $false
)
if ($all) {
	$reg = $true
	$procs = $true
	$files = $true}
function Get-RandomString {
    $charSet = "abcdefghijklmnopqrstuvwxyz0123456789".ToCharArray()    
    for ($i = 0; $i -lt 10; $i++ ) {
    $randomString += $charSet | Get-Random}
    return $randomString}
if ($procs) {
    $VBoxTray = Get-Process "VBoxTray" -ErrorAction SilentlyContinue
    if ($VBoxTray) {
        $VBoxTray | Stop-Process -Force }
        $VBoxService = Get-Process "VBoxService" -ErrorAction SilentlyContinue
    if ($VBoxService) {
        $VBoxService | Stop-Process -Force}}
if ($reg){
    if (Get-ItemProperty -Path "HKLM:\HARDWARE\Description\System" -Name "SystemBiosVersion" -ErrorAction SilentlyContinue) {
	    Set-ItemProperty -Path "HKLM:\HARDWARE\Description\System" -Name "SystemBiosVersion" -Value $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SystemInformation" -ErrorAction SilentlyContinue) {
	    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SystemInformation" -Name "BIOSVersion" -Value $(Get-RandomString)
	    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SystemInformation" -Name "BIOSReleaseDate" -Value $(Get-RandomString)
	    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SystemInformation" -Name "BIOSProductName" -Value $(Get-RandomString)}
    if (Get-ItemProperty -Path "HKLM:\HARDWARE\Description\System" -Name "SystemBiosDate" -ErrorAction SilentlyContinue) {
	    Set-ItemProperty -Path "HKLM:\HARDWARE\Description\System" -Name "SystemBiosDate" -Value $(Get-RandomString)}
    if (Get-ItemProperty -Path "HKLM:\HARDWARE\Description\System" -Name "VideoBiosVersion" -ErrorAction SilentlyContinue) {
	    Set-ItemProperty -Path "HKLM:\HARDWARE\Description\System" -Name "VideoBiosVersion" -Value $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\SOFTWARE\Oracle\VirtualBox Guest Additions" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\SOFTWARE\Oracle\VirtualBox Guest Additions" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\HARDWARE\ACPI\DSDT\VBOX__" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\HARDWARE\ACPI\DSDT\VBOX__" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\HARDWARE\ACPI\FADT\VBOX__" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\HARDWARE\ACPI\FADT\VBOX__" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\HARDWARE\ACPI\RSDT\VBOX__" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\HARDWARE\ACPI\RSDT\VBOX__" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxMouse" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxMouse" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxService" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxService" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxSF" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxSF" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxVideo" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxVideo" -NewName $(Get-RandomString)}
    if (Get-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxGuest" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\SYSTEM\ControlSet001\services\VBoxGuest" -NewName $(Get-RandomString)}
    if (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "VBoxTray" -ErrorAction SilentlyContinue) {
	    Rename-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "VBoxTray" -NewName $(Get-RandomString)}
    if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Oracle VM VirtualBox Guest Additions" -ErrorAction SilentlyContinue) {
	    Rename-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Oracle VM VirtualBox Guest Additions" -NewName $(Get-RandomString)}}
    else {
        Write-Output 'Error'  
    }
if ($files) {
    $vboxFiles1 = "C:\Windows\System32\drivers\VBox*"
    if ($vboxFiles1) {
        Remove-Item $vboxFiles1}
    $vboxFiles2 = "C:\Windows\System32\VBox*"
    Remove-Item $vboxFiles2 -EV Err -ErrorAction SilentlyContinue
    Rename-Item "C:\Windows\System32\VBoxMRXNP.dll" "C:\Windows\System32\$(Get-RandomString).dll"
    Rename-Item "C:\Program Files\Oracle\VirtualBox Guest Additions" "C:\Program Files\Oracle\$(Get-RandomString)"}
    Write-Output 'Basarili'