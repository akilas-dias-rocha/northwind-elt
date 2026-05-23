import sqlite3
import pandas as pd
import os

db_path = os.getenv("DB_PATH")

try:
    conn = sqlite3.connect(db_path)
    print("Conexão bem-sucedida!")

    # Lista todas as tabelas do banco
    tables = pd.read_sql("SELECT name FROM sqlite_master WHERE type='table'", conn)
    print(tables)

    # Lê uma tabela específica
    df = pd.read_sql("SELECT * FROM Customer LIMIT 5", conn)
    print(df)

except sqlite3.Error as e:
    print(f"Erro ao conectar: {e}")

finally:
    conn.close()
