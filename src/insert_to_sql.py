# 📂 src/insert_to_sql.py - Inserta los datos recopilados en SQL Server

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
