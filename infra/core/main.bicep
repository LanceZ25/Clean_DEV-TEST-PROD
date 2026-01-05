
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

// ✅ Removed purge protection parameter and hardcoded it in kvModule
// Storage Account
module storageModule './storage.bicep' = {
  name: 'storageModule'
  params: {
    storageAccountName: storageAccountName
    location: location
  }
}

// Key Vault (always enable purge protection)
module kvModule './keyvault.bicep' = {
  name: 'kvModule'
  params: {
    keyVaultName: keyVaultName
    location: location
    tenantId: tenantId
    // Removed enablePurgeProtection param; handled inside keyvault.bicep
  }
}

// App Configuration
module appConfigModule './appconfig.bicep' = {
  name: 'appConfigModule'
  params: {
    appConfigName: appConfigName
    location: location
  }
}

// Application Insights
module appInsightsModule './appinsights.bicep' = {
  name: 'appInsightsModule'
  params: {
    appInsightsName: appInsightsName
    location: location
  }
}

// Azure AI Foundry
module aifModule './ai-foundry.bicep' = {
  name: 'aifModule'
  params: {
    aifName: aifName
    location: location
  }
}



