$Name = 'FieldSecurity' 
$DEVDatabase = "$($Name)_DEV"
$ORIGDatabase = "$($Name)_ORIG" 
$MyServer = 'localhost\NAVDEMO'
#$MyServer = 'NAVDEMO'
$FilterString = 'Version List=*FLS1.00*'
$Eula_ = 'https://106c4.wpc.azureedge.net/80106C4/Gallery-Prod/cdn/2015-02-24/prod20161101-microsoft-windowsazure-gallery/csc-eclipse.e1cc447f-7ef6-47bb-8a40-bab9c6834839-preview.1.0.2/Content/LegalTerms0.DEFAULT.txt'
$PrivacyStatement_ = 'http://www.uxceclipse.ca/privacy-policy/'
$Description_ = 'Field Level Security for Microsoft Dynamics 365 for Financials'
$Help_ = 'http://webasset.uxceclipse.com/wp-content/uploads/2017/06/05170100/FieldSecurity-User-Guide-0617.pdf'
#$Logo_ = 'http://webasset.uxceclipse.com/wp-content/uploads/2017/06/05165234/exceed-field-security-logo-400-300x139.jpg'
$Logo_ = 'C:\_Workingfolder\FieldSecurity\logo\logo.png'
$Url_ = 'http://www.uxceclipse.com/field-security'
$Brief_ = 'Field Security provides easy-to-deploy, configurable field level security control for Microsoft Dynamics 365 for Financials'


$WorkingFolder = 'C:\_Workingfolder\FieldSecurity\CreateExtensionPackage' 

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


#Export Original

<#
if (-not(Test-Path $OriginalText)){
 Export-NAVApplicationObject `
 –DatabaseServer $MyServer `
  -DatabaseName $ORIGDatabase `  
   -ExportTxtSkipUnlicensed `  
   -Path $OriginalText `     
    -Force `  
     -Verbose } 

#>

<#
Export-NAVApplicationObject `
–DatabaseServer $MyServer `
 -DatabaseName $ORIGDatabase `
  -ExportTxtSkipUnlicensed `
   -Path $Originaltext `
    #-Filter $FilterString `
    -Force `
     -Verbose
#>

#Export Modified

<#
Export-NAVApplicationObject `
–DatabaseServer $MyServer `
 -DatabaseName $DEVDatabase `
  -ExportTxtSkipUnlicensed `
   -Path $Modifiedtext `
    -Filter $FilterString `
    -Force `
     -Verbose
#>

 #Create deltas
<#
Compare-NAVApplicationObject `
 -OriginalPath $OriginalText `
  -ModifiedPath $Modifiedtext `
   -DeltaPath $DeltaPath `
    -Force `
     -Verbose

#>
#Export Permission
<#
 Set Export-NAVAppPermissionSet `
 -Path $PermissionSet `
  -PermissionSetId 'SF-SUPER' `
   -ServerInstance $DEVDatabase `    
     -Force `
      -Verbose 
#>



#Handle Manifest Manifest

<#
$Manifest = Get-NAVAppManifest `
 -Path $ManifestFile `
  -Verbose `
   -ErrorAction SilentlyContinue 
#>
<#
if (-not($Manifest)){ $Manifest = New-NAVAppManifest `
 -Name $name `
  -Publisher 'UXC Eclipse' `
   -Description $Description_ `
   -EULA $Eula_ `
   -PrivacyStatement $PrivacyStatement_ `
   -Help $Help_ `
   -Url $Url_ ` 
   #-Brief $Brief_ `  
   #-Logo $Logo_ `      
   -Version '1.0.0.2'
 }    
 #>
<#
$Manifest = Get-NAVAppManifest `
 -Path $ManifestFile `
  -Verbose `
   -ErrorAction SilentlyContinue 

$Manifest.AppVersion = 
"$($Manifest.AppVersion.Major).$($Manifest.AppVersion.Minor).$($Manifest.AppVersion.Build).$($Manifest.AppVersion.Revision + 1)" 
$Manifest | New-NAVAppManifestFile -Path $ManifestFile -Force

#Create Package
 New-NAVAppPackage `
 -Path $NAVAppPackageFile `
  -Manifest $Manifest `
   -SourcePath $DeltaPath `
   -Logo $Logo_ `
    -Verbose `
     -Force 
     
 Get-NAVAppInfo -Path $NAVAppPackageFile 
 
 #Start $WorkingFolder
 
 #>

 $Manifest = Get-NAVAppManifest `
 -Path $ManifestFile `
  -Verbose `
   -ErrorAction SilentlyContinue 

 #Create Package
 New-NAVAppPackage `
 -Path $NAVAppPackageFile `
  -Manifest $Manifest `
   -SourcePath $DeltaPath `
   -Logo $Logo_ `
    -Verbose `
     -Force 

Get-NAVAppInfo -Path $NAVAppPackageFile 