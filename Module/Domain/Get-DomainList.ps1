<#
.SYNOPSIS
Retrieves a list of domains from Linode.

.DESCRIPTION
The Get-DomainList function retrieves a list of domains from the Linode API. Optionally, you can provide custom headers and an EnableException switch.

.PARAMETER headers
Optional custom headers to use when making the API request. Defaults to $global:config.Headers if not provided.

.PARAMETER EnableException
An optional switch that, when used, will throw an exception on failure instead of silently continuing.

.EXAMPLE
Get-DomainList
#>
function Get-DomainList {
    [CmdletBinding()]
    param (
        [hashtable]$headers = $global:config.Headers,
        [switch]$EnableException
    )
    
    
    $url = "https://api.linode.com/v4/domains"
    $method = "GET"

    try {
        $result = (Invoke-RestMethod -Uri $url -Headers $headers -Method $method -ErrorAction Stop).data | `
            Foreach-Object { [Domain]($_) }
    }
    catch {
        Stop-PSFFunction -Message "Failed to get domain list" -ErrorRecord $_ -EnableException $EnableException
        return
    }
    
    return $result
}