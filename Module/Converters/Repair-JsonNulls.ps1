function Repair-JsonNulls {
    param (
        [Parameter(Position=0,Mandatory=$true,ValueFromPipeline)]
        [string]$json,
        [switch]$includeZeros
    )

    if($includeZeros){
        $json = $json.Replace(': "0"',': null')
        $json = $json.Replace(': 0',': null')
    }

    return $json.Replace(': ""',': null')
}