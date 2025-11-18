from db_config import connect_db
from llm_engine import ask_llm
from query_executor import run_query
from schema_loader import load_schema
from chroma_rag import index_schema_in_chroma, retrieve_schema_context

def main():
    print("\nText-to-SQL Chatbot (Chroma RAG Mode)")
    print("--------------------------------\n")

    schema_text = load_schema()
    index_schema_in_chroma(schema_text)  # Index once at startup

    conn = connect_db()

    try:
        while True:
            print()  # adds a blank line before prompt
            user_input = input("Please type here: ").strip()
            if user_input.lower() == "exit":
                print("Goodbye.")
                break
            elif user_input.lower() == "rollback":
                conn.rollback()
                print("All uncommitted changes rolled back.\n")
                continue
            elif user_input.lower() == "commit":
                conn.commit()
                print("All pending changes committed.\n")
                continue

            rag_context = retrieve_schema_context(user_input)
            sql_query = ask_llm(user_input, rag_context)
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