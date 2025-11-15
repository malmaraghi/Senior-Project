# 🧠 Text-to-SQL Chatbot

## Overview

A local Text-to-SQL chatbot that translates natural-language questions into valid SQL queries for structured company databases. Built using the Llama 3.1 (8B) model via Ollama.

---

## Phase 1 - Current Implementation

### Key Features

- **LLM Translation** – Converts plain English into SQL queries
- **Schema-Only Access** – The LLM has access only to the database schema, never the actual records
- **Dummy Database** – Tested on a small demo database with sample tables and records
- **Full CRUD Mode** – Supports `SELECT`, `INSERT`, `UPDATE`, and `DELETE` operations
- **Transaction Control** – Includes `COMMIT` and `ROLLBACK` for safe testing
- **Error Handling** – Detects and explains SQL constraint violations 

### Project Structure

```
OLLAMA-TEXT2SQL/
├── .venv/                    # Virtual environment
├── .pycache_/                # Python cache files
├── db_config.py              # Database configuration
├── llm_engine.py             # LLM query generation
├── main.py                   # Main application entry point
├── query_executor.py         # Database execution engine
├── schema_loader.py          # Schema import and context
```

---

## Phase 2 - Roadmap

### Planned Enhancements

1. **RAG Integration**  
   Replace manual schema prompting with a Retrieval-Augmented Generation (RAG) pipeline

2. **Real Database**  
   Connect to a larger, realistic company dataset

3. **Model Comparison**  
   Evaluate performance across three LLMs:
   - Llama 3.1 8B
   - Additional model 
   - Additional model 

4. **Efficiency Analysis**  
   Measure and compare:
   - Accuracy
   - Latency
   - Resource usage on small vs. large databases
