
using '../core/main.bicep'

param storageAccountName = 'carioaistoragedev'
param keyVaultName       = 'cario-ai-vault-dev'
param appConfigName      = 'cario-appconfig-dev'
param appInsightsName    = 'cario-ai-insights-dev'
param aifName            = 'cario-aifoundry-dev'
param location           = 'australiaeast'

// Critical checks:
param tenantId               = 'bfe60da2-f477-42dc-b9cc-7b90b087e92e'
param enablePurgeProtection  = false   // dev

