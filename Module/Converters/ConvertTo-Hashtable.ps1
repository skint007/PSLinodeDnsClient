function ConvertTo-Hashtable {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline)]
        $InputObject
    )

    process {

        if ($null -eq $InputObject) { return $null }
        if ($InputObject -is [Hashtable] -or $InputObject.GetType().Name -eq 'OrderedDictionary') { return $InputObject }

        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) { ConvertTo-Hashtable $object }
            )

            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject]) {
            $hash = @{}

            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable $property.Value
            }

            $hash
        }
        else {
            $InputObject
        }

    }
}