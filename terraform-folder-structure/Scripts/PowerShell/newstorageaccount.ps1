param (
    [Parameter(Mandatory = $true)][string] $subscriptionid,
    [Parameter(Mandatory = $true)][string] $resourcegroupname,
    [Parameter(Mandatory = $true)][string] $storageaccountname,
    [Parameter(Mandatory = $true)][string] $location,
    [Parameter(Mandatory = $true)][string] $tenantId,
    [Parameter(Mandatory = $true)][string] $clientID,
    [Parameter(Mandatory = $true)][string] $clientSecret
)

$SecurePassword = ConvertTo-SecureString -String $clientSecret -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $clientID, $SecurePassword


#Check to see if module exist
If (Get-Module -ListAvailable -Name Az) {
}
else {
Write-Host "Module does not exist"
  Try{
    Install-Module -Name Az -Repository PSGallery -Force -ErrorAction Stop -Scope CurrentUser -Verbose
}
  Catch{
    Throw $_.Exception.Message
} 
}  

# Connect to Azure using service principal
Connect-AzAccount -ServicePrincipal -TenantId $tenantId -Credential $Credential -SubscriptionId $subscriptionId

# create storage account
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction SilentlyContinue

if ($storageAccount -eq $null) {
    Write-Host "Storage account '$storageAccountName' does not exist. Creating..."

    # Create a new resource group if it doesn't exist
    New-AzResourceGroup -Name $resourceGroupName -Location $location -Force

    # Create the storage account
    $storageConfig = @{
        ResourceGroupName = $resourceGroupName
        AccountName = $storageAccountName
        SkuName = "Standard_GRS"  # Adjust as needed
        Location = $location
	    EnableHttpsTrafficOnly = $true
	    AllowBlobPublicAccess  = $false
        PublicNetworkAccess    = "Disabled"
        MinimumTlsVersion      = "TLS1_2"
        AllowSharedKeyAccess   = $false
    }

    New-AzStorageAccount @storageConfig

    Write-Host "Storage account '$storageAccountName' created successfully."
} else {
    Write-Host "Storage account '$storageAccountName' already exists. Exiting..."
}