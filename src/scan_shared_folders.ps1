# 📂 src/scan_shared_folders.ps1 - Escanea carpetas compartidas
```
$SharedFolders = Get-SmbShare | Where-Object {$_.Name -ne "ADMIN$"}
foreach ($folder in $SharedFolders) {
    Get-SmbShareAccess -Name $folder.Name | Select-Object Name, AccountName, AccessControlType | Export-Csv -Path "./shared_folders.csv" -Append -NoTypeInformation
}
```