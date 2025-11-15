import mysql.connector as mariadb
import sys

DB_CONFIG = {
    "user": "root",
    "password": "password",
    "host": "localhost",
    "port": 3306,
    "database": "bank_demo_large"
}

def connect_db():
    """
    Create and return a MariaDB connection using credentials defined in DB_CONFIG.
    """
    try:
        conn = mariadb.connect(**DB_CONFIG)
        return conn
    except mariadb.Error as e:
        print(f"Database connection failed: {e}")
        sys.exit(1)
