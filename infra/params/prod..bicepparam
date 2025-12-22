
using '../core/main.bicep'

param storageAccountName = 'carioaistoragedev'
param keyVaultName       = 'cario-ai-vault-dev'
param appConfigName      = 'cario-appconfig-dev'
param appInsightsName    = 'cario-ai-insights-dev'
param aifName            = 'cario-aifoundry-dev'
param location           = 'australiaeast'

// Critical checks:
param tenantId               = '1c147026-fa0d-40e2-a7ed-aa606a8c4ef9'
param enablePurgeProtection  = true


