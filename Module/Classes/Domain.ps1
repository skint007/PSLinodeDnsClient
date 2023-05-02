class Domain {
    [int]$id                # This Domain’s unique ID
    [string]$domain         # The domain this Domain represents. Domain labels cannot be longer than 63 characters and must conform to RFC1035.
    [string[]]$tags         # An array of tags applied to this object. Tags are for organizational purposes only.
    [string]$group          # The group this Domain belongs to. This is for display purposes only.
    [string]$status         # Enum: disabled active Default: active
    [string]$errors         # 
    [string]$description    # A description for this Domain.
    [string]$soa_email      # Start of Authority email address. This is required for type master Domains.
    [int]$retry_sec         # The interval, in seconds, at which a failed refresh should be retried.
    [string[]]$master_ips   # The IP addresses representing the master DNS for this Domain. At least one value is required for type slave Domains.
    [string[]]$axfr_ips     # The list of IPs that may perform a zone transfer for this Domain.
    [int]$expire_sec        # The amount of time in seconds that may pass before this Domain is no longer authoritative.
    [int]$refresh_sec       # The amount of time in seconds before this Domain should be refreshed.
    [int]$ttl_sec           # Valid values are 300, 3600, 7200, 14400, 28800, 57600, 86400, 172800, 345600, 604800, 1209600, and 2419200
    [string]$type           # Enum: master slave
    [string]$created        # When this Domain Record was created.
    [string]$updated        # When this Domain Record was last updated.
}