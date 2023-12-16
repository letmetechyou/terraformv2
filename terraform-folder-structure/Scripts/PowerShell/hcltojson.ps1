<#
.SYNOPSIS
    Combines all tfvars into a .tfvars.json with same key values.

.DESCRIPTION
    Utilizing HCL2PS Module, this builds a hash table and combines all tfvars files in a folder based on the keys of the maps.  
    This is expecting map(object({})) tfvars
    The output is a .tfvars.json file

.PARAMETER Folder
    'Folder' parameter: The location for the tfvars files.  ".\<folder>"

.PARAMETER Environment
    'Environment' parameter: This is used to name the tfvars.json file.  <Environment>.tfvars.json

.PARAMETER Recursive
    'Recursive' parameter: Determines if the search for tfvars files will search recursively

.LINK
    URL or link to additional documentation.

.EXAMPLE
    ..\Scripts\merge-tfvars-json.ps1 -Folder .\sandbox -Environment sbx -Recursive $True

#>

param (
    [Parameter(Mandatory = $true)][string] $Folder,
    [Parameter(Mandatory = $true)][string] $Environment,
    [Parameter()][bool]$Recursive = $true
)

#Check to see if module exist
If (Get-Module -ListAvailable -Name Hcl2PS) {
}
else {
Write-Host "Module does not exist"
  Try{
    Install-Module -Name Hcl2PS -Force -ErrorAction Stop -Scope CurrentUser -Verbose
}
  Catch{
    Throw $_.Exception.Message
} 
}  

# Install Hcl2PS Module
#Install-Module -Name Hcl2PS -Force -ErrorAction Stop -Scope CurrentUser

# Get a list of .tfvars files matching the pattern recursively.  Add to Hashtable TFVars
$TFVars = @{}
$TFVars.Files = Get-ChildItem -Path "$Folder\*.tfvars" -File -Recurse:$Recursive -ErrorAction SilentlyContinue

# Write to screen the QTY of files found
Write-Host "---------------------------------------------------------"
Write-Host "QTY:$($TFVars.Files.Count) - .tfvars files found matching the pattern: $Folder\*.tfvars"
Write-Host "---------------------------------------------------------"
$TFVars.Files.FullName
Write-Host "---------------------------------------------------------"

# Convert each file to Json as a hashtable and add to the Hashtable TFVars under Json
$TFVars.Json = @{}

for($qty = 0; $qty -lt $TFVars.Files.count; $qty++) {
        
        $TFVars.Json."File$($qty)" = (ConvertFrom-Hcl -Path $TFVars.Files[$qty] -AsJson) | ConvertFrom-Json -AsHashtable
      
}

# Based on the map name, merge values and store them in the Hashtable TFVars under Merge.
$TFVars.Merge = @{}
$TFVars.Merge.MapKeys = $TFVars.Json.Values.keys | Sort-Object -Unique

# Write the qty and values of the keys found.
Write-Host "---------------------------------------------------------"
Write-Host "QTY:$($TFVars.Merge.MapKeys.count) - Map Keys found:"
Write-Host "---------------------------------------------------------"
$TFVars.Merge.MapKeys
Write-Host "---------------------------------------------------------"

$TFVars.Merge.MapKeys | ForEach-Object{
        $MapKey = $_
        $count = ($TFVars.Json.Values | Where-Object {$_.keys -eq $MapKey}).Count
        $TFVars.Merge."$MapKey" = @{}


# Create a hashtable to store encountered keys
$encounteredKeys = @{}
$encounteredKeys["Duplicate"] = $false

$MainKey = $TFVars.json.values.$MapKey

        foreach ($ResourceKey in $MainKey.keys) {
            # Check if the Resource has been encountered before
            if ($encounteredKeys.ContainsKey("$ResourceKey")) {
                Write-Host "Duplicate Resource found: $MapKey.$ResourceKey"
                $encounteredKeys["Duplicate"] = $true
            } 
            else {
                # Add the Resource to the encountered keys hashtable
                Write-Host "Found Resource Key $MapKey.$ResourceKey"
                $encounteredKeys["$ResourceKey"] = $true
            }
        }

        if ($encounteredKeys["Duplicate"] -eq $false) {
        
                for($qty = 0; $qty -lt $count; $qty++){
                        
                        if ($count -lt 2){
                                $TFVars.Merge."$MapKey" += ($TFVars.Json.Values | Where-Object {$_.keys -eq $MapKey}).$MapKey
                        }
                        else {
                        $TFVars.Merge."$MapKey" += ($TFVars.Json.Values | Where-Object {$_.keys -eq $MapKey})[$qty].$MapKey
                        }
                }
        }
        elseif ($encounteredKeys["Duplicate"] -eq $true){
                Write-Host "Duplicates found - Stopping"
                exit
        }
        
}
# Clear MapKeys for Conversion
$TFVars.Merge.Remove('MapKeys')
# Generate a file of the combined values in all the TFVars as Json and save in the root.
$TFVars.Merge | ConvertTo-Json -Depth 100 | Out-File -FilePath "$Environment.tfvars.json" -Encoding utf8
