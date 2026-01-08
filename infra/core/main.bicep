
targetScope = 'resourceGroup'

@description('Name of the Storage Account')
param storageAccountName string

@description('Name of the Key Vault')
param keyVaultName string

@description('Name of the App Configuration resource')
param appConfigName string

@description('Name of the Application Insights resource')
param appInsightsName string

@description('Name of the Azure AI Foundry resource')
param aifName string

@description('Azure location (defaults to resource group location)')
param location string = resourceGroup().location

@description('AAD Tenant ID for Key Vault')
param tenantId string


@description('App Configuration tier (free=Dev/Test, standard=Prod)')
@allowed([
  'free'
  'standard'
])
param appConfigTier string = 'free'


@description('Public network access setting for Key Vault')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'

@description('Kind for Azure AI Foundry (e.g., AIServices)')
param kind string = 'AIServices'

@description('SKU name for Azure AI Foundry (e.g., S0)')
param skuName string = 'S0'

// -----------------------------
// Storage Account
// -----------------------------
module storageModule './storage.bicep' = {
  name: 'storageModule'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

// -----------------------------
// Key Vault (always enable purge protection inside keyvault.bicep)
// Pass publicNetworkAccess so your parameter file matches.
// -----------------------------
module kvModule './keyvault.bicep' = {
  name: 'kvModule'
  params: {
    keyVaultName: keyVaultName
    location: location
    tenantId: tenantId
    publicNetworkAccess: publicNetworkAccess
  }
}

// -----------------------------
// App Configuration
// -----------------------------
module appConfigModule './appconfig.bicep' = {
  name: 'appConfigModule'
  params: {
    appConfigName: appConfigName
    location: location
    tier: appConfigTier
  }
}

// -----------------------------
// Application Insights
// -----------------------------
module appInsightsModule './appinsights.bicep' = {
  name: 'appInsightsModule'
  params: {
    appInsightsName: appInsightsName
    location: location
  }
}

// -----------------------------
// Azure AI Foundry
// Pass kind and skuName so your parameter file validates.
// -----------------------------
module aifModule './ai-foundry.bicep' = {
  name: 'aifModule'
  params: {
    aifName: aifName
    location: location
    kind: kind
    skuName: skuName
  }
}


