Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "itla.local" -DomainNetbiosName "ITLA" -InstallDns -SafeModeAdministratorPassword (ConvertTo-SecureString "Lab12345!" -AsPlainText -Force) -Force

New-ADGroup -Name "RDS-Basico" -GroupScope Global
New-ADGroup -Name "RDS-Privilegiado" -GroupScope Global

$pw = ConvertTo-SecureString "Lab12345!" -AsPlainText -Force
New-ADUser -Name "basico" -SamAccountName "basico" -UserPrincipalName "basico@itla.local" -AccountPassword $pw -Enabled $true -PasswordNeverExpires $true
New-ADUser -Name "privilegiado" -SamAccountName "privilegiado" -UserPrincipalName "privilegiado@itla.local" -AccountPassword $pw -Enabled $true -PasswordNeverExpires $true

Add-ADGroupMember -Identity "RDS-Basico" -Members "basico"
Add-ADGroupMember -Identity "RDS-Privilegiado" -Members "privilegiado"
