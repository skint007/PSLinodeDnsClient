# Import PSLinodeDnsClient module.
# Make sure you have already installed the PSFramework module as it is required for logging
Import-Module "$PSScriptRoot\PSLinodeDnsClient"

try {
    # Query ipinfo.io for our public IP
    $ipinfo = Invoke-WebRequest -Uri "http://ipinfo.io/json" -ErrorAction Stop
}
catch {
    Stop-PSFFunction -Message "http://ipinfo.io/json - returned a '$($ipinfo.StatusCode)' code. Expected 200" -Target $ipinfo -ErrorRecord $_ -EnableException $true
    return
}

try {
    # Parse the IP from the response
    $publicIP = ($ipinfo.Content | ConvertFrom-Json).ip
}
catch {
    Stop-PSFFunction -Message "`$ipinfo.Content' was malformed" -Target $ipinfo -ErrorRecord $_ -EnableException $true
    return
}

# Get list of DNS's using Get-DomainList, excluding the ones from the exclude list
$domainList = Get-DomainRecordsList $Global:config.DomainId | Where-Object { 
    -not $global:config.Exclude.Contains($_.Name) -and $_.type -eq "A" `
    -and $_.target -ne $publicIP
}

if($domainList.Count -gt 0){
    Write-PSFMessage -Level Debug -Message "Filtered Get-DomainRecordsList $($Global:config.DomainId) returned $($domainList.Count)"
}

# Go through each returned record and attempt to update the DNS
$domainList | ForEach-Object {
    Write-PSFMessage -Level Debug -Message "Updating '$($_.name)' from '$($_.target)' to '$publicIP'"

    # Update the target property with the new public IP
    $_.target = $publicIP

    # Update the domain record with the new public IP
    $result = $_ | Update-DomainRecord $Global:config.DomainId
    if($result){
        Write-PSFMessage -Level Debug -Message "Update successful for record $($_.id)" -Target $result
        continue
    }

    Stop-PSFFunction -Message "Update failed for record $($_.id)" -Target $_
}
