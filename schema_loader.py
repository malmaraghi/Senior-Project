def load_schema():
    """
    Fetch the CREATE TABLE statements for all tables from the connected MariaDB instance.
    """
    import mysql.connector as mariadb
    from db_config import DB_CONFIG

    try:
        conn = mariadb.connect(**DB_CONFIG)
        cur = conn.cursor()
        cur.execute("SHOW TABLES;")
        tables = [row[0] for row in cur.fetchall()]

        schema_text = ""
        for table in tables:
            cur.execute(f"SHOW CREATE TABLE `{table}`;")
            result = cur.fetchone()
            if result and len(result) > 1:
                schema_text += f"{result[1]};\n\n"
        cur.close()
        conn.close()
        return schema_text
    except Exception as e:
        return f"Could not read schema from DB: {e}"