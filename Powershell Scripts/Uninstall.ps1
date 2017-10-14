Get-NAVAppInfo -ServerInstance FieldSecurity_TEST -Tenant Default | Uninstall-NAVApp -Tenant Default -Verbose
Unpublish-NAVApp -ServerInstance FieldSecurity_TEST -Path 'C:\_Workingfolder\FieldSecurity\CreateExtensionPackage\FieldSecurity.navx' -Verbose
Get-NAVAppInfo -ServerInstance FieldSecurity_TEST
Get-NAVAppInfo -ServerInstance ItemClassification_TEST
Unpublish-NAVApp -ServerInstance ItemClassification_TEST -Name 'ItemClassification'
Uninstall-NAVApp -ServerInstance ItemClassification_TEST -Name 'ItemClassification'

Unpublish-NAVApp -ServerInstance FieldSecurity_TEST -Name 'FieldSecurity'
Uninstall-NAVApp -ServerInstance FieldSecurity_TEST -Name 'FieldSecurity' -Version 1.0.0.6 -Tenant Default -DoNotSaveData

Get-NAVTenant –ServerInstance FieldSecurity_TEST
Get-NAVAppInfo -ServerInstance FieldSecurity_TEST -Tenant Default | Uninstall-NAVApp -Tenant Default
