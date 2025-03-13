# 📂 tests/test_insert_to_sql.py - Pruebas para validación de inserción en SQL

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
