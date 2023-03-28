from llama_index import GPTSimpleVectorIndex, SimpleDirectoryReader

documents = SimpleDirectoryReader('data').load_data()
index = GPTSimpleVectorIndex(documents)
index.save_to_disk('index.json')

index = GPTSimpleVectorIndex.load_from_disk('index.json')
response = index.query("TODO?")
print(response)
