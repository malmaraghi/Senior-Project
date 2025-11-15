import ollama

# Installed models: 'llama3.1:8b' / 'gemma3:4b'
model_name = "llama3.1:8b"

def ask_llm(question, schema_text, model_name=model_name):
    prompt = f"""
You are an expert SQL assistant for MariaDB.

You are allowed to generate the following SQL commands:
  SELECT, INSERT, UPDATE, DELETE, SHOW, DESCRIBE.

Rules:
- For SHOW requests that refer to database tables, generate:
    SHOW TABLES;
- For DESCRIBE requests that refer to a specific table, generate:
    DESCRIBE <table_name>;
- For INSERT commands:
    * Always specify the column names explicitly.
    * Use NULL for any columns not mentioned by the user.
    * Never assume or infer missing values.
- For UPDATE commands:
    * Modify only the fields explicitly mentioned by the user.
- For DELETE commands:
    * Include a WHERE clause to specify which records to delete.
    * Do not delete all records unless the user explicitly requests it.
- If the user asks to join tables or show tables together, create a single SELECT query that joins the related tables using their foreign keys. 
  Join only the tables that have clear relationships in the schema. Select readable columns from each table and present the merged data in one result.
    

The database schema is:

{schema_text}

User request: "{question}"

Return ONLY the SQL query (no explanation, no extra text).
"""
    try:
        response = ollama.chat(model=model_name,
                               messages=[{"role": "user", "content": prompt}])
        sql_query = response["message"]["content"]
        return sql_query.strip().replace("```sql", "").replace("```", "").strip()
    except Exception as e:
        return f"LLM Error: {e}"
