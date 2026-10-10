Install-WindowsFeature Web-Server -IncludeManagementTools
Import-Module WebAdministration

$cert = New-SelfSignedCertificate -DnsName "web-caja","10.7.30.139" -CertStoreLocation Cert:\LocalMachine\My -NotAfter (Get-Date).AddYears(2)
New-WebBinding -Name "Default Web Site" -Protocol https -Port 443
(Get-WebBinding -Name "Default Web Site" -Protocol https).AddSslCertificate($cert.Thumbprint, "My")
Remove-WebBinding -Name "Default Web Site" -Protocol http -Port 80

New-NetFirewallRule -DisplayName "HTTPS-443" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow
