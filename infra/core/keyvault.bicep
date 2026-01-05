
targetScope = 'resourceGroup'

@description('Name of the Key Vault')
param keyVaultName string

@description('Azure location')
param location string

@description('SKU for Key Vault')
param skuName string = 'standard'

@description('Enable purge protection (true/false)')
param enablePurgeProtection bool = true

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
    enablePurgeProtection: enablePurgeProtection
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    publicNetworkAccess: 'Enabled'
  }
}


