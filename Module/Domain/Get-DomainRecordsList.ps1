<#
.SYNOPSIS
Retrieves a list of domain records for a specified domain in Linode.

.DESCRIPTION
The Get-DomainRecordsList function retrieves a list of domain records from the Linode API for a specified domain ID. Optionally, you can provide custom headers and an EnableException switch.

.PARAMETER domainId
The ID of the domain for which the list of records should be retrieved.

.PARAMETER headers
Optional custom headers to use when making the API request. Defaults to $global:config.Headers if not provided.

.PARAMETER EnableException
An optional switch that, when used, will throw an exception on failure instead of silently continuing.

.EXAMPLE
Get-DomainRecordsList -domainId 1234
#>
function Get-DomainRecordsList {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline)]
        [int]$domainId,
        [hashtable]$headers = $global:config.Headers,
        [switch]$EnableException
    )
    
    $url = "https://api.linode.com/v4/domains/$domainId/records"
    $method = "GET"

    try {
        $result = (Invoke-RestMethod -Uri $url -Headers $headers -Method $method -ErrorAction Stop).data | `
            Foreach-Object { [Record]($_) }
    }
    catch {
        Stop-PSFFunction -Message "Failed to get record list for Domain: $domainId" -ErrorRecord $_ -EnableException $EnableException
        return
    }
    
    return $result
}