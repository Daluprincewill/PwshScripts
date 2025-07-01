############# Start with Environment checks
function Test-ifAdmin {
    # Returns $true is script is running as admin, $false otherwise
$currentuser= [security.principal.windowsidentity]::GetCurrent()
$principal=New-Object Security.principal.windowsprincipal($currentuser)
return
$principal.IsInRole([security.principal.windowsBuiltInRole]::Administrator)

if(-not (Test-ifAdmin)) {
    Write-Warning "tf going on? you're not administrator, you're not him. get tf outta here"
    exit 1
}
} 
function get-OSversionInfo{
    $os=(Get-CimInstance Win32_OperatingSystem).Caption
    if ($os -notmatch "Windows Server") {
        write-warning "Bitch! this shit for ADDS for fuck sake. Current OS : $os"
        return $false
    }
    return $true
}
if (-not (get-OSversionInfo)){
    exit 1
}
function get-ADDSInstallstatus {
    $ADDSstatus=Get-WindowsFeature -name AD-Domain-services
    return $ADDSstatus.installed
}
if (get-ADDSInstallstatus){
    Write-Host "ayeee, let's get this shit Twin. ADDS role already installed"
}else {
    Write-Host "ADDS is not installed,, Twin. Lemme fix that real quick"
    install-WindowsFeature -Name AD-Domain-services, DNS, DHCP, GPMC -IncludeManagementTools
}
################################################################################################
$config= get-content C:\Users\Administrator\Desktop\Scripts\domain_config.JSON  | ConvertFrom-Json

$DomainName= $config.DomainName
$NetBios = $config.NetBios
$SafeModePassword= ConvertTo-SecureString $config.SafeModePassword -AsPlainText -Force

if ($config.installDNS) {
install-WindowsFeature DNS -IncludeManagementTools
}

if ($config.installDHCP){
install-windowsfeature DHCP -IncludeManagementTools
}

if ($config.installGPMC){
install-windowsfeature GPMC -IncludeManagementTools 
}

import-module ActiveDirectory
install-addsforest -DomainName $DomainName -DomainNetbiosName $NetBios -SafeModeAdministratorPassword $SafeModePassword

if ($config.RebootAfter){
    write-host "standby Twin, I'mma get right with you...rebooting now"
    Restart-Computer -force
}
###########################################################################################################
