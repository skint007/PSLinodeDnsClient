<#
.SYNOPSIS
Retrieves a specific domain from Linode.

.DESCRIPTION
The Get-Domain function retrieves a specific domain from the Linode API for a specified domain ID. Optionally, you can provide custom headers and an EnableException switch.

.PARAMETER domainId
The ID of the domain to be retrieved.

.PARAMETER headers
Optional custom headers to use when making the API request. Defaults to $global:config.Headers if not provided.

.PARAMETER EnableException
An optional switch that, when used, will throw an exception on failure instead of silently continuing.

.EXAMPLE
Get-Domain -domainId 1234
#>
function Get-Domain {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline)]
        [int]$domainId,
        [hashtable]$headers = $global:config.Headers,
        [switch]$EnableException
    )
    
    $url = "https://api.linode.com/v4/domains/$domainId"
    $method = "GET"

    try {
        $result = [Domain](Invoke-RestMethod -Uri $url -Headers $headers -Method $method -ErrorAction Stop)
    }
    catch {
        Stop-PSFFunction -Message "Failed to get domain for: $domainId" -ErrorRecord $_ -EnableException $EnableException
        return
    }
    
    return $result
}