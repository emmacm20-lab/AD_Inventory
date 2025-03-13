# 📂 src/send_reports.ps1 - Envío de reportes por correo
```
$SMTPServer = "smtp.ejemplo.com"
$From = "reporte@empresa.com"
$To = "auditoria@empresa.com"
$Subject = "Reporte de Inventario AD"
$Body = "Adjunto el reporte de usuarios y accesos en AD."
$Attachment = "./ad_users.csv"
Send-MailMessage -To $To -From $From -Subject $Subject -Body $Body -SmtpServer $SMTPServer -Attachments $Attachment
```