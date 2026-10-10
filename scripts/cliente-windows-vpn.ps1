# 1. Crear la conexión L2TP sobre IPsec con clave compartida
Add-VpnConnection -Name "VPN-Jump" -ServerAddress 202.50.73.254 -TunnelType L2tp -L2tpPsk "Lab12345" -AuthenticationMethod MSChapv2 -EncryptionLevel Optional -SplitTunneling $true -RememberCredential -Force

# 2. Fijar la propuesta IPsec al nivel del FortiGate (DES, SHA1, grupo DH 14, sin PFS)
Set-VpnConnectionIPsecConfiguration -ConnectionName "VPN-Jump" -AuthenticationTransformConstants SHA196 -CipherTransformConstants DES -EncryptionMethod DES -IntegrityCheckMethod SHA1 -DHGroup Group14 -PfsGroup None -Force

# 3. Ruta hacia la LAN del Jump Server (túnel dividido)
Add-VpnConnectionRoute -ConnectionName "VPN-Jump" -DestinationPrefix 10.7.30.128/29

rasdial "VPN-Jump" basico "Lab12345!"          # Cliente Básico
rasdial "VPN-Jump" privilegiado "Lab12345!"    # Cliente Privilegiado
ipconfig

