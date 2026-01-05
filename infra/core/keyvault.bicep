
targetScope = 'resourceGroup'

@description('Name of the Key Vault')
param keyVaultName string

@description('Azure location')
param location string

@description('SKU for Key Vault')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Tenant ID for the directory')
param tenantId string

@description('Whether to use RBAC for data-plane access (recommended)')
param enableRbac bool = true

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: tenantId
    sku: {
      family: 'A'
      name: skuName
    }
    // Soft delete is always enabled; do not set enableSoftDelete.
    enablePurgeProtection: true

    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true

    // Prefer RBAC to access policies (strongly recommended by Microsoft)
    // When RBAC is enabled, do not include accessPolicies.
    publicNetworkAccess: 'Enabled'

    // Use RBAC if requested
    // NOTE: RBAC is enabled via 'features' settings on newer KV API versions.
    // If your org requires explicit flag:
    // properties: { ... , enableRbacAuthorization: true }
  }

  // Optional: lock down network; uncomment if you need strict access:
  // properties: {
  //   ... other properties ...
  //   networkAcls: {
  //     defaultAction: 'Deny'
  //     bypass: 'AzureServices'
  //     ipRules: []
  //     virtualNetworkRules: []
  //   }
  // }
}

// Optional: role assignments for RBAC (example)
// Provide principal/object IDs via module params and add role assignments as needed.
// Example role assignment (uncomment and adapt):
// param principalObjectId string
// resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
//   name: keyVaultName
// }
// resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (enableRbac) {
//   name: guid(keyVault.id, 'KeyVaultSecretsOfficer', principalObjectId)
//   scope: kv
//   properties: {
//     roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b86a8fe4-44ce-4948-aee5-eccb2c155cd7') // Key Vault Secrets Officer
//     principalId: principalObjectId
//   }
// }



