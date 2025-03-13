
# 📂 src/collect_ad_data.ps1 - Obtiene información de Active Directory
```
Import-Module ActiveDirectory
Get-ADUser -Filter * -Property DisplayName, MemberOf, LastLogonDate | Select-Object DisplayName, MemberOf, LastLogonDate | Export-Csv -Path "./ad_users.csv" -NoTypeInformation
```
