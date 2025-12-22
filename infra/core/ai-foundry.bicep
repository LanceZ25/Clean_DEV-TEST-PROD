
targetScope = 'resourceGroup'

@description('Name of the Azure AI Service resource')
param aifName string

@description('Azure location')
param location string

@description('API kind for the AI resource')
param kind string = 'AIServices'

resource aiFoundry 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: aifName
  location: location
  kind: kind
  sku: {
    name: 'S0' // Standard tier for AI Services
  }
  properties: {
    apiProperties: {
      // Add any specific API properties if needed
    }
  }
}

