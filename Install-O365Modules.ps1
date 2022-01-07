<#
    Name: Install-O365Modules.ps1
    Description: Installs and imports all of Microsoft's PowerShell modules to administer Microsoft 365 tenants
#>

$modules = @(
    "ExchangeOnlineManagement",
    "AzureAD",
    "MSOnline",
    "Microsoft.Online.SharePoint.PowerShell",
    "SharePointPnPPowerShellOnline",
    "MicrosoftTeams"
)
function Install-Modules {
    # TODO: Update this logic to use Get-InstalledModule for a more concise function
    foreach($m in $modules) {
        $isImported = Get-Module | Where-Object {$_.Name -eq $m}
        $isAvailable = Get-Module -ListAvailable | Where-Object {$_.Name -eq $m}
        $notInstalled = Find-Module -Name $m | Where-Object {$_.Name -eq $m}
        if($isImported) {
            write-host "Module $isImported is already imported" -ForegroundColor Red
        } elseif ($isAvailable) {
            write-host "Importing module $m"
            Import-Module -Name $m -Verbose
        } elseif ($notInstalled) {
            write-host "Installing module $m"
            Install-Module -Name $m -Force -Verbose -Scope CurrentUser
            Import-Module -Name $m -Verbose
        } else {
            write-host "Module $m not imported, or not available"
            EXIT 1
        }
    }
}

    write-host ""
    write-host "`nWill now attempt to install and import all Microsoft 365 PowerShell modules"
    write-host "`nConnect to the services after installation by running Connect-[modulename] e.g., Connect-ExchangeOnlineManagement"
    Install-Modules