<#
.SYNOPSIS
Retrieves a specific domain record for a specified domain in Linode.

.DESCRIPTION
The Get-DomainRecord function retrieves a specific domain record from the Linode API for a specified domain ID and record ID. Optionally, you can provide custom headers and an EnableException switch.

.PARAMETER domainId
The ID of the domain for which the domain record should be retrieved.

.PARAMETER recordId
The ID of the specific domain record to retrieve.

.PARAMETER headers
Optional custom headers to use when making the API request. Defaults to $global:config.Headers if not provided.

.PARAMETER EnableException
An optional switch that, when used, will throw an exception on failure instead of silently continuing.

.EXAMPLE
Get-DomainRecord -domainId 1234 -recordId 5678
#>
function Get-DomainRecord {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline)]
        [int]$domainId,
        [Parameter(Position=1, Mandatory=$true)]
        [int]$recordId,
        [hashtable]$headers = $global:config.Headers,
        [switch]$EnableException
    )
    
    $url = "https://api.linode.com/v4/domains/$domainId/records/$recordId"
    $method = "GET"

    try {
        $result = [Record](Invoke-RestMethod -Uri $url -Headers $headers -Method $method -ErrorAction Stop)
    }
    catch {
        Stop-PSFFunction -Message "Failed to get domain record Domain/Record: $domainId/$recordId" -ErrorRecord $_ -Target $result -EnableException $EnableException
        return
    }
    
    return $result
}