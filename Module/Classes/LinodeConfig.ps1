class LinodeConfig {
    [string]$DomainId
    [hashtable]$Headers
    [hashtable]$logConfig
    [string[]]$Exclude

    hidden LinodeConfig() {
        <# Always use [LinodeConfig]::Load() #>
    }

    [void] static Load() {
        # We can't just load the config and cast it to the LinodeConfig type, thanks hashtables >:(
        $config = (Get-Content -Path "$PSScriptRoot\..\config.json" -Raw | ConvertFrom-Json)
        $global:config = [LinodeConfig]::New()
        $global:config.DomainId = $config.DomainId
        $global:config.Headers = $config.Headers | ConvertTo-Hashtable
        $global:config.LogConfig = $config.LogConfig | ConvertTo-Hashtable
        $global:config.Exclude = $config.Exclude

        #Setup logging
        $logging = $global:config.logConfig
        Set-PSFLoggingProvider @logging
    }
}