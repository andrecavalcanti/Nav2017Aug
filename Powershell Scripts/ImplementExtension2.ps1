$Name = 'FieldSecurity'
#$Name2 = 'ItemClassification'
$TESTDatabase = "$($Name)_TEST_Old"
#$TESTDatabase = "$($Name)"

$WorkingFolder = 'C:\_Workingfolder\FieldSecurity\CreateExtensionPackage'

#Prepare Environment 
$NAVAppPackageFile = Join-Path $WorkingFolder "$($Name).navx"
$SandboxDBName = "$($TESTDatabase)_$($Name)_Sandbox"
$PublishFolder = Join-Path $WorkingFolder 'Publish'
if (-not(Test-Path $PublishFolder)){New-Item -Path $PublishFolder -ItemType directory} 

#Remove If Already Exists
$ExistingNAVApp = Get-NAVAppInfo ` -ServerInstance $TESTDatabase ` | Where Name -eq $Name
<#
if ($ExistingNAVApp) { $ExistingNAVApp | Uninstall-NAVApp -Verbose $ExistingNAVApp | Unpublish-NAVApp } 

#Publish The NAVX 

Publish-NAVApp ` -Path $NAVAppPackageFile ` -ServerInstance $TESTDatabase ` -Verbose ` -LogPath (Join-Path $PublishFolder 'Log.txt') ` 
#-SkipVerification 
#>

#start $PublishFolder
Get-NAVAppInfo -ServerInstance $TESTDatabase -Name $Name | Install-NAVApp ` -ServerInstance $TESTDatabase `
<# 

#Start-NAVWindowsClient -ServerInstance $TESTDatabase

Get-NAVAppInfo -ServerInstance $TESTDatabase  | Uninstall-NAVApp  -Verbose
#>