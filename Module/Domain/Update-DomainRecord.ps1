<#
.SYNOPSIS
Updates a domain record for a specified domain in Linode.

.DESCRIPTION
The Update-DomainRecord function updates an existing domain record in the Linode API. 
It requires a domain ID and a Record object with updated properties. Optionally, you 
can provide custom headers and an EnableException switch.

.PARAMETER domainId
The ID of the domain for which the record should be updated.

.PARAMETER updateObject
The Record object containing the updated properties for the domain record.

.PARAMETER headers
Optional custom headers to use when making the API request. Defaults to $global:config.Headers if not provided.

.PARAMETER EnableException
An optional switch that, when used, will throw an exception on failure instead of silently continuing.

.EXAMPLE
Update-DomainRecord -domainId 1234 -updateObject $recordToUpdate
#>
function Update-DomainRecord {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [int]$domainId,
        [Parameter(Position=1, Mandatory=$true, ValueFromPipeline)]
        [Record]$updateObject,
        [hashtable]$headers = $global:config.Headers,
        [switch]$EnableException
    )
    Write-PSFMessage -Level Debug -Message "Starting Update-DomainRecord for domainId: $domainId and Record ID: $($updateObject.id)"
    
    $url = "https://api.linode.com/v4/domains/$domainId/records/$($updateObject.id)"
    $method = "PUT"
    $validObj = [ordered]@{
        "name"= $updateObject.name
        "target"= $updateObject.target
        "priority"= $updateObject.priority
        "weight"= $updateObject.weight
        "port"= $updateObject.port
        "service"= $updateObject.service
        "protocol"= $updateObject.protocol
        "ttl_sec"= $updateObject.ttl_sec
        "tag"= $updateObject.tag
    }
    $status = ""
    try {
        $response = Invoke-RestMethod -Uri $url `
            -Headers $headers `
            -Method $method `
            -StatusCodeVariable status `
            -ErrorAction Stop `
            -Body ($validObj | ConvertTo-Json | Repair-JsonNulls)
    }
    catch {
        Stop-PSFFunction -Message "Failed to update record Domain/Record: $domainId/$($updateObject.id)" -ErrorRecord $_ -Target $validObj -EnableException $EnableException
        return
    }
    
    if($status -eq 200) {
        Write-PSFMessage -Level Debug -Message "Update-DomainRecord succeeded for domainId: $domainId and Record ID: $($updateObject.id)"
        return $true
    }
    else {
        Write-PSFMessage -Level Error -Message "Update-DomainRecord failed for domainId: $domainId and Record ID: $($updateObject.id) with status: $status" -Data $response
        return $false
    }
}