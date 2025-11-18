import re
from typing import List
import chromadb
import ollama

EMBEDDING_MODEL = "embeddinggemma:latest"

def chunk_schema(schema_text: str):
    # Matches CREATE TABLE ... (...); including multiline
    pattern = re.compile(
        r"CREATE TABLE\s+`?(\w+)`?\s*\((.*?)\)[^;]*;",
        re.IGNORECASE | re.DOTALL
    )
    chunks = []
    for match in pattern.finditer(schema_text):
        table_name = match.group(1)
        statement_full = match.group(0).strip()
        chunks.append({"name": table_name, "content": statement_full})
    if not chunks and schema_text:
        chunks.append({"name": "full_schema", "content": schema_text})
    return chunks

def embed_texts(texts: List[str], model: str = EMBEDDING_MODEL) -> List[List[float]]:
    """Get embeddings from Ollama for a list of strings."""
    response = ollama.embed(model=model, input=texts)
    return response["embeddings"]

        
def index_schema_in_chroma(schema_text: str, persist_path: str = "./chroma_db"):
    chroma_client = chromadb.Client(settings=chromadb.Settings(persist_directory=persist_path))
    collection = chroma_client.get_or_create_collection(name="db_schema")

    chunks = chunk_schema(schema_text)
    print("Table chunks found:")             # <--- Add this
    for chunk in chunks:
        print(chunk["name"])                 # <--- Add this
    texts = [chunk["content"] for chunk in chunks]
    embeddings = embed_texts(texts)
    ...

    for idx, chunk in enumerate(chunks):
        collection.add(
            ids=[str(idx)],
            documents=[chunk["content"]],
            metadatas=[{"table_name": chunk["name"]}],
            embeddings=[embeddings[idx]],
        )
    print(f"Schema indexed: {len(chunks)} tables.")

def retrieve_schema_context(question: str, top_k: int = 3, persist_path: str = "./chroma_db"):
    chroma_client = chromadb.Client(settings=chromadb.Settings(persist_directory=persist_path))
    collection = chroma_client.get_collection("db_schema")

    question_emb = embed_texts([question])[0]
    results = collection.query(
        query_embeddings=[question_emb],
        n_results=top_k,
        include=["documents", "metadatas"]
    )
    context_list = []
    for doc, meta in zip(results["documents"][0], results["metadatas"][0]):
        context_list.append(f"-- Table: {meta['table_name']}\n{doc}")
    return "\n\n".join(context_list) if context_list else "No relevant tables found."