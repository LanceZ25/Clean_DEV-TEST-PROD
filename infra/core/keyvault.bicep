
targetScope = 'resourceGroup'

@description('Name of the Key Vault')
param keyVaultName string

@description('Azure location')
param location string = resourceGroup().location

@description('SKU for Key Vault')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Tenant ID for the directory')
param tenantId string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: skuName
    }
    // Soft-delete is always enabled by default in this API version
    // Purge protection: Disabled (matches your current vault state)
    enablePurgeProtection: false

    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    publicNetworkAccess: 'Enabled'
  }
}



