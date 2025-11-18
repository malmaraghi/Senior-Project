import mariadb
from tabulate import tabulate

def run_query(sql_query, conn, auto_commit=True):
    """Execute SELECT/INSERT/UPDATE/DELETE safely with transaction control."""
    cur = conn.cursor()
    sql_lower = sql_query.strip().lower()

    try:
        if sql_lower.startswith(("select", "show", "describe", "explain")):
            cur.execute(sql_query)
            rows = cur.fetchall()
            col_names = [desc[0] for desc in cur.description]
            if not rows:
                print("No records found.\n")
            else:
                print("\nQuery Results:\n")
                print(tabulate(rows, headers=col_names, tablefmt="fancy_grid"))
        else:
            cur.execute(sql_query)
            print(f"Query executed successfully. ({cur.rowcount} rows affected)")

            if auto_commit:
                conn.commit()
                print("Changes committed.\n")
            else:
                print("Transaction pending (not committed yet). Use COMMIT or ROLLBACK.\n")
    except mariadb.Error as e:
        print(f"SQL Error: {e}\nThe query could not be executed. Please rephrase your request or check the generated SQL.\n")
    except Exception as e:
        print(f"Unexpected error: {e}\n")
    finally:
        cur.close()