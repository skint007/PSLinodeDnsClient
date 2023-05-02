class Record {
    [int]$id            # This Record’s unique ID
    [string]$type       # Enum: A AAAA NS MX CNAME TXT SRV PTR CAA
    [string]$name       # The name of this Record. For requests, this property’s actual usage and whether it is required depends on the type of record this represents
    [string]$target     # The target for this Record. For requests, this property’s actual usage and whether it is required depends on the type of record this represents:
    [int]$priority      # The priority of the target host for this Record. Lower values are preferred. Only valid for MX and SRV record requests. Required for SRV record requests.
    [int]$weight        # The relative weight of this Record used in the case of identical priority. Higher values are preferred. Only valid and required for SRV record requests.
    [int]$port          # The port this Record points to. Only valid and required for SRV record requests.
    [string]$service    # The name of the service. An underscore (_) is prepended and a period (.) is appended automatically to the submitted value for this property. Only valid and required for SRV record requests.
    [string]$protocol   # The protocol this Record’s service communicates with. An underscore (_) is prepended automatically to the submitted value for this property. Only valid for SRV record requests.
    [int]$ttl_sec       # Valid values are 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, and 2419200
    [string]$tag        # Enum: issue issuewild iodef
    [string]$created    # When this Domain Record was created.
    [string]$updated    # When this Domain Record was last updated.
}