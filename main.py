from db_config import connect_db
from llm_engine import ask_llm
from query_executor import run_query
from schema_loader import load_schema

def main():
    print("\nText-to-SQL Chatbot (Full Database Access Mode)")
    print("--------------------------------")
    print("Usage:")
    print(" - SELECT:   Retrieve data (e.g., list all customers)")
    print(" - INSERT:   Add new records (e.g., add new customer)")
    print(" - UPDATE:   Modify existing records (e.g., update customer city)")
    print(" - DELETE:   Remove records without linked dependencies")
    print(" - SCHEMA:   View structure (show tables, describe customers)")
    print(" - COMMIT:   Save pending changes")
    print(" - ROLLBACK: Undo uncommitted changes")
    print(" - EXIT:     Quit the chatbot")
    print("--------------------------------\n")

    schema_text = load_schema()
    conn = connect_db()

    try:
        while True:
            user_input = input("Please type here: ").strip().lower()
            if user_input == "exit":
                print("Goodbye.")
                break
            elif user_input == "rollback":
                conn.rollback()
                print("All uncommitted changes rolled back.\n")
                continue
            elif user_input == "commit":
                conn.commit()
                print("All pending changes committed.\n")
                continue

            print("\nGenerating SQL query...")
            sql_query = ask_llm(user_input, schema_text)
            print(f"\nSuggested SQL:\n{sql_query}\n")

            confirmation = input("Execute this query? (y/n): ").strip().lower()
            if confirmation != "y":
                print("Skipped.\n")
                continue

            run_query(sql_query, conn, auto_commit=False)
    finally:
        conn.close()
        print("Connection closed.")

if __name__ == "__main__":
    main()
