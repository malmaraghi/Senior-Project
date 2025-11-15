def load_schema(schema_file="bank_demo_schema.sql"):
    """Read the schema file for LLM context."""
    try:
        with open(schema_file, "r") as f:
            return f.read()
    except FileNotFoundError:
        return "Schema file not found."
