$Name = 'FieldSecurity' 
$Name1 = 'Demo Database NAV (9-0)' 
$Name2 = 'NAV2017' 
$DEVDatabase = "$($Name1)" 
$ORIGDatabase = "$($Name2)" 
$MyServer = 'NAV2017\NAVDEMO'
$FilterString = 'Version List=*ECSP*'

$WorkingFolder = 'C:\_Workingfolder\ItemClassification\CreateExtensionPackage' 

#Prepare Environment
$ExportFolder = Join-Path $WorkingFolder 'Exports' 
$OriginalText = Join-Path $ExportFolder 'Original.txt' 
$Modifiedtext = Join-Path $ExportFolder 'Modified.txt' 
$DeltaPath = Join-Path $WorkingFolder 'AppFiles' 
$NAVAppPackageFile = Join-Path $WorkingFolder "$($Name).navx" 
$ManifestFile = Join-Path $WorkingFolder "Manifest.xml" 
$PermissionSet = Join-Path $DeltaPath 'PermissionSet.xml' 

if (-not(Test-Path $ExportFolder)){New-Item -Path $ExportFolder -ItemType 
directory} if (-not(Test-Path $WorkingFolder)){New-Item -Path $WorkingFolder -ItemType 
directory} if (-not(Test-Path $DeltaPath)){New-Item -Path $DeltaPath -ItemType directory} 

<#

#Export Original
if (-not(Test-Path $OriginalText)){ 
 Export-NAVApplicationObject `
 –DatabaseServer $MyServer `
  -DatabaseName $ORIGDatabase `
   -ExportTxtSkipUnlicensed `
    -Path $OriginalText `
    -Filter $FilterString `
     -Verbose } 

#>

#Export Modified

Export-NAVApplicationObject `
–DatabaseServer $MyServer `
 -DatabaseName $DEVDatabase `
  -ExportTxtSkipUnlicensed `
   -Path $Modifiedtext `
   -Filter $FilterString `
    -Force `
     -Verbose



<#
 #Create deltas
Compare-NAVApplicationObject `
 -OriginalPath $OriginalText `
  -ModifiedPath $Modifiedtext `
   -DeltaPath $DeltaPath `
    -Force `
     -Verbose

#Export Permission

 Set Export-NAVAppPermissionSet `
  -PermissionSetId 'SUPER' `
   -ServerInstance $DEV `
    -Path $PermissionSet `
     -Force `
      -Verbose 
#>

<#

#Handle Manifest Manifest
$Manifest = Get-NAVAppManifest `
 -Path $ManifestFile `
  -Verbose `
   -ErrorAction SilentlyContinue 

if (-not($Manifest)){ $Manifest = New-NAVAppManifest `
 -Name $name `
  -Publisher 'Cloud Ready Software GmbH' `
   -Description 'Field Security' `
    -Version '1.0.0.0' 
} 

$Manifest.AppVersion = 
"$($Manifest.AppVersion.Major).$($Manifest.AppVersion.Minor).$($Manifest.AppVersion.Build).$($Manifest.AppVersion.Revision + 1)" 
$Manifest | New-NAVAppManifestFile -Path $ManifestFile -Force

#Create Package
 New-NAVAppPackage `
 -Path $NAVAppPackageFile `
  -Manifest $Manifest `
   -SourcePath $DeltaPath `
    -Verbose `
     -Force 
     
 Get-NAVAppInfo -Path $NAVAppPackageFile 

 Start $WorkingFolder
 
 #>