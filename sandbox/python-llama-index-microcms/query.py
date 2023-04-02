from llama_index import GPTSimpleVectorIndex
import sys

index = GPTSimpleVectorIndex.load_from_disk('index.json')

prompt = "\n".join(sys.stdin)
print(f'Prompt: {prompt}')

response = index.query(prompt)
print(f'Answer: {response}')
