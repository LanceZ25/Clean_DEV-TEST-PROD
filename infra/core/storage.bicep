
targetScope = 'resourceGroup'

@description('Name of the Storage Account')
param storageAccountName string

@description('Azure location')
param location string

@description('SKU for Storage Account')
param skuName string = 'Standard_LRS' // Locally-redundant storage

@description('Account kind')
param kind string = 'StorageV2'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: kind
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}
