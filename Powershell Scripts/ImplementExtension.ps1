$Name = 'FieldSecurity'
#$Name2 = 'ItemClassification'
$TESTDatabase = "$($Name)_TEST"
#$TESTDatabase = "$($Name)"

$WorkingFolder = 'C:\_Workingfolder\FieldSecurity\CreateExtensionPackage'

#Prepare Environment 
$NAVAppPackageFile = Join-Path $WorkingFolder "$($Name).navx"
$SandboxDBName = "$($TESTDatabase)_$($Name)_Sandbox"
$PublishFolder = Join-Path $WorkingFolder 'Publish'
if (-not(Test-Path $PublishFolder)){New-Item -Path $PublishFolder -ItemType directory} 

#Remove If Already Exists

$ExistingNAVApp = Get-NAVAppInfo ` -ServerInstance $TESTDatabase ` -Tenant Default | Where Name -eq $Name
Get-NAVAppInfo ` -ServerInstance $TESTDatabase ` -Tenant Default | Where Name -eq $Name

if ($ExistingNAVApp) { $ExistingNAVApp | Uninstall-NAVApp -Verbose $ExistingNAVApp | Unpublish-NAVApp } 

#Publish The NAVX 

Publish-NAVApp ` -Path $NAVAppPackageFile ` -ServerInstance $TESTDatabase ` -Verbose ` -LogPath (Join-Path $PublishFolder 'Log.txt') ` -SkipVerification 


#start $PublishFolder

Get-NAVAppInfo -ServerInstance $TESTDatabase -Name $Name | Install-NAVApp ` -ServerInstance $TESTDatabase ` -Tenant Default 

Start-NAVWindowsClient -ServerInstance $TESTDatabase

#Get-NAVAppInfo -ServerInstance $TESTDatabase -Tenant Default | Uninstall-NAVApp -Tenant Default -Verbose
#Import-Module PKI
#Get-Command -Module PKI
<#
New-SelfSignedCertificate -DnsName "self.signed.cert" -CertStoreLocation Cert:\CurrentUser\My
New-SelfSignedCertificate -DnsName "www.fabrikam.com", "www.contoso.com" -CertStoreLocation "cert:\LocalMachine\My"
SignTool sign /f MyCert.pfx /p MyPassword "C:\NAV\Proseware.navx"
#>

#Publish-NAVApp -SkipVerification:$SkipVerification -Path $NAVAppPackageFile -ServerInstance $TESTDatabase -ErrorAction Stop

#SignTool sign /f MyCert.pfx /p MyPassword "C:\NAV\FieldSecurity.navx"

<#
New-SelfSignedCertificate -DnsName "www.uxceclispse.com" -CertStoreLocation "cert:\LocalMachine\My" 
New-SelfSignedCertificate -DnsName "www.uxceclispse.com" -CertStoreLocation "cert:\CurrentUser\My" 
New-SelfSignedCertificate -DnsName www.fabrikam.com, www.contoso.com -CertStoreLocation cert:\LocalMachine\My

makecert -n "CN=PowerShell Local Certificate Root" -a sha1 -eku 1.3.6.1.5.5.7.3.3 -r -sv root.pvk root.cer -ss Root -sr localMachine

New-SelfSignedCertificate -DnsName STA07 -Type CodeSigning

New-SelfsignedCertificateEx -Subject "CN=Field Security" -EKU "Code Signing" -KeySpec "Signature" -KeyUsage "DigitalSignature" -FriendlyName "Field Security" -Path C:\temp\ssl.pfx -Password (ConvertTo-SecureString "ac10671" -AsPlainText -Force) -Exportable

New-SelfsignedCertificateEx -Subject "CN=www.domain.com" -EKU "Server Authentication", "Client authentication" -KeyUsage "KeyEncipherment, DigitalSignature" -SAN "sub.domain.com","www.domain.com","192.168.1.1" -AllowSMIME -Path C:\test\ssl.pfx -Password (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) -Exportable -StoreLocation "LocalMachine"
#>