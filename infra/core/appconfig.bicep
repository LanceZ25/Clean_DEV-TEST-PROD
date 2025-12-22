
targetScope = 'resourceGroup'

@description('Name of the App Configuration resource')
param appConfigName string

@description('Azure location')
param location string

@description('Pricing tier for App Configuration')
param skuName string = 'Standard' // Default is Standard; Developer is for non-prod

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: appConfigName
  location: location
  sku: {
    name: skuName
  }
  properties: {
    // Telemetry disabled by default
    disableLocalAuth: false
    encryption: {
      keyVaultProperties: null
    }
  }
}
