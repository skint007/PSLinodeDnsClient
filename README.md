# About PSLinodeDnsClient Module
The PSLinodeDnsClient module is a PowerShell module that provides a set of functions to interact with the Linode API for managing domains and domain records. It allows users to perform operations such as retrieving a list of domains and records, fetching specific domains or records, and updating domain records. This module makes it easy for you to manage your Linode DNS settings programmatically using PowerShell.

# Prerequisites
1. This module was tested with Powershell 7.3, but should also work with 5.1. It was tested on Windows and Ubuntu Linux, you can find the install instructions below.
   * Powershell Core for [Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows)
   * Powershell Core for [Linux](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux)
1. This module uses `PSFramework` so make sure you install that before hand.
   * Make sure your pwsh or terminal is running with elevated privileges and run the below command to install
        ```powershell
        Install-Module PSFramework
        ```
   * You can confirm the module installed by running the following command
        ```powershell
        Get-Module -ListAvailable PSFramework
        ```
1. Make sure to edit the `config.json` file and change the DomainId and Authentication header with your API key. The config file is loaded when the module is imported.
    * After putting your API key in the config, you can use `Get-DomainList` to fetch a list of your domains and get the Id of the domain you want to run the script against.

# Example uses
Take a look at the [Example script](/ExampleCheckForDnsUpdate.ps1) for a working script to automatically update your Linode DNS's.

## Get-DomainRecordsList
```powershell
# Retrieve a list of domain records for a specific domain
Get-DomainRecordsList -domainId 1234
```

Example output as array of `Record`:
```
id       : 1234
type     : A
name     : subdomain
target   : 123.456.789.012
priority : 0
weight   : 0
port     : 0
service  :
protocol :
ttl_sec  : 0
tag      :
created  : 04/04/2023 04:47:59
updated  : 04/15/2023 01:25:43

id       : 5678
type     : MX
name     :
target   : sub.domain
priority : 10
weight   : 0
port     : 0
service  :
protocol :
ttl_sec  : 0
tag      :
created  : 06/02/2022 19:25:52
updated  : 06/02/2022 21:15:06
```

## Get-DomainRecord
```powershell
# Retrieve a specific domain record using domain ID and record ID
Get-DomainRecord -domainId 1234 -recordId 5678
```
Example output as type `Record`:
```
id       : 1234
type     : A
name     : subdomain
target   : 123.456.789.012
priority : 0
weight   : 0
port     : 0
service  :
protocol :
ttl_sec  : 0
tag      :
created  : 04/04/2023 04:47:59
updated  : 04/15/2023 01:25:43
```

## Get-DomainList
```powershell
# Retrieve a list of domains from Linode
Get-DomainList
```
Example output as array of `Domain`:
```
id          : 1234
domain      : mydomain.toplevel
tags        : {}
group       :
status      : active
errors      :
description :
soa_email   : myemail@service.com
retry_sec   : 0
master_ips  : {}
axfr_ips    : {}
expire_sec  : 0
refresh_sec : 0
ttl_sec     : 0
type        : master
created     : 06/02/2022 19:25:50
updated     : 04/27/2023 16:51:03

id          : 5678
domain      : myseconddomain.toplevel
tags        : {}
group       :
status      : active
errors      :
description :
soa_email   : myemail@service.com
retry_sec   : 0
master_ips  : {}
axfr_ips    : {}
expire_sec  : 0
refresh_sec : 0
ttl_sec     : 0
type        : master
created     : 06/02/2022 22:40:40
updated     : 04/18/2023 20:21:05

```


## Get-DomainList
```powershell
# Retrieve a specific domain using its domain ID
Get-Domain -domainId 1234
```
Outputs type Domain

## Update-DomainRecord
Example on updating existing record IP
```powershell
# Retrieve a specific domain record using domain ID and record ID
$recordToUpdate = Get-DomainRecord -domainId 1234 -recordId 5678

# Update an existing domain record with new properties
$recordToUpdate.target = "192.168.1.1"

Update-DomainRecord -domainId 1234 -updateObject $recordToUpdate
```

Output is `true` or `false` depending if it was successful.