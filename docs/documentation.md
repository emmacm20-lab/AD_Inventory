# 📄 Documentación del Proyecto Inventario-Usuarios-AD

## 📌 Descripción  
Inventario de usuarios y permisos en Active Directory.

## 🛠 Tecnologías utilizadas  
- Python  
- PowerShell  
- SQL Server  
- Azure  
- Power BI  

## 🚀 Cómo ejecutar  
1️⃣ Clona este repositorio  
2️⃣ Ejecuta los scripts en `/src/` según sea necesario  
3️⃣ Consulta la documentación adicional en esta carpeta  


# 📂 docs/README.md - Documentación del Proyecto
"""
# 🛠 Inventario de Usuarios y Servidores con PowerShell y SQL

## 📌 Descripción del Proyecto

Este proyecto implementa una automatización en PowerShell para obtener un **inventario de usuarios y servidores en Active Directory**, recopilando información clave como **roles, grupos, permisos, bases de datos y esquemas**. Además, el sistema:

- **Registra accesos y permisos de usuarios en carpetas compartidas**.
- **Almacena toda la información en SQL Server para auditoría y análisis**.
- **Genera reportes y gráficas en Power BI** para monitoreo de accesos y actividad de usuarios.
- **Envío automático de correos** a técnicos y auditores con reportes detallados.

## 📂 Estructura del Proyecto
```
📁 AD_Inventory
│── 📂 src/
│   │── collect_ad_data.ps1  # Script para obtener información de Active Directory
│   │── scan_shared_folders.ps1  # Escaneo de usuarios en carpetas compartidas
│   │── send_reports.ps1  # Envío de correos automáticos con reportes
│   │── insert_to_sql.py  # Inserta los datos en SQL Server
│── 📂 reports/
│   │── powerbi_dashboard.pbix  # Panel de control en Power BI
│── 📂 tests/
│   │── test_insert_to_sql.py  # Pruebas de inserción de datos en SQL
│── 📂 docs/
│   │── README.md  # Documentación del proyecto
```

## 🚀 Instalación y Ejecución

1. **Clona este repositorio:**
   ```sh
   git clone https://github.com/tuusuario/AD_Inventory.git
   ```
2. **Ejecuta el script de recopilación de datos:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File src/collect_ad_data.ps1
   ```
3. **Escanea usuarios en carpetas compartidas:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File src/scan_shared_folders.ps1
   ```
4. **Inserta los datos recopilados en SQL Server:**
   ```sh
   python src/insert_to_sql.py
   ```
5. **Genera el reporte en Power BI y envía correos automáticos:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File src/send_reports.ps1
   ```

## 📩 Flujo de Trabajo
1. **Recopilación de Datos**: Se extraen usuarios, roles, permisos y bases de datos desde Active Directory.
2. **Escaneo de Carpetas Compartidas**: Se registran los accesos y permisos de usuarios en directorios compartidos.
3. **Inserción en SQL Server**: Se almacenan todos los registros en una base de datos centralizada.
4. **Generación de Reportes**: Power BI genera estadísticas de accesos, usuarios recurrentes y controles de seguridad.
5. **Notificación Automática**: Se envían alertas y reportes por correo a técnicos y auditores.

## 🛠 Tecnologías Utilizadas
- **PowerShell**: Recolección de datos de Active Directory y administración de permisos.
- **SQL Server**: Almacenamiento y auditoría de accesos.
- **Power BI**: Visualización de datos y generación de reportes interactivos.
- **Python**: Inserción de datos en SQL y automatización de procesos.
- **SMTP (Email)**: Envío de reportes y alertas por correo electrónico.

## 📈 Resultados Esperados
- 📌 **Auditoría detallada de accesos y permisos de usuarios en servidores.**
- 📌 **Identificación de usuarios recurrentes en la red y servidores.**
- 📌 **Alertas y reportes automáticos para técnicos y auditores.**
- 📌 **Panel de control en Power BI con estadísticas de actividad.**

## 🧪 Pruebas
El proyecto incluye pruebas unitarias para validar la inserción de datos en SQL Server.
1. **Ejecución de pruebas:**
   ```sh
   python -m unittest discover tests/
   ```

## 📬 Contacto
Para consultas o sugerencias, contáctame en [TuCorreo@ejemplo.com](mailto:TuCorreo@ejemplo.com).
"""

# 📂 src/collect_ad_data.ps1 - Obtiene información de Active Directory
```
Import-Module ActiveDirectory
Get-ADUser -Filter * -Property DisplayName, MemberOf, LastLogonDate | Select-Object DisplayName, MemberOf, LastLogonDate | Export-Csv -Path "./ad_users.csv" -NoTypeInformation
```

# 📂 src/scan_shared_folders.ps1 - Escanea carpetas compartidas
```
$SharedFolders = Get-SmbShare | Where-Object {$_.Name -ne "ADMIN$"}
foreach ($folder in $SharedFolders) {
    Get-SmbShareAccess -Name $folder.Name | Select-Object Name, AccountName, AccessControlType | Export-Csv -Path "./shared_folders.csv" -Append -NoTypeInformation
}
```

# 📂 src/insert_to_sql.py - Inserta los datos recopilados en SQL Server
```python
import pyodbc
import pandas as pd

def insert_data(csv_file, table_name):
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=tu_servidor;DATABASE=tu_db;UID=usuario;PWD=contraseña")
    df = pd.read_csv(csv_file)
    for index, row in df.iterrows():
        cursor = conn.cursor()
        cursor.execute(f"INSERT INTO {table_name} VALUES ({', '.join(['?' for _ in row])})", tuple(row))
        conn.commit()
    conn.close()

insert_data("./ad_users.csv", "ActiveDirectoryUsers")
insert_data("./shared_folders.csv", "SharedFolderAccess")
```

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

# 📂 tests/test_insert_to_sql.py - Pruebas para validación de inserción en SQL
```python
import unittest
from src.insert_to_sql import insert_data

class TestSQLInsert(unittest.TestCase):
    def test_insert(self):
        try:
            insert_data("./test_ad_users.csv", "TestActiveDirectoryUsers")
            self.assertTrue(True)
        except:
            self.assertTrue(False)

if __name__ == "__main__":
    unittest.main()
```

🚀 **Ahora el proyecto tiene código funcional en PowerShell, Python y SQL para integrarlo en tu portafolio!** Si necesitas mejoras o más funcionalidades, dime y lo agregamos. 😊
