# Dot source all the ps1 module files
Get-ChildItem -Path $PSScriptRoot\*.ps1 -File -Recurse | Sort-Object | ForEach-Object { . $_.FullName }

# Initialize the config
[LinodeConfig]::Load()