from llama_index import GPTSimpleVectorIndex, SimpleWebPageReader
import logging
import sys

logging.basicConfig(stream=sys.stdout, level=logging.DEBUG, force=True)

# documents = SimpleWebPageReader().load_data([
#     "https://wikiwiki.jp/nijisanji/",
# ])
# index = GPTSimpleVectorIndex(documents)
# index.save_to_disk('index.json')

index = GPTSimpleVectorIndex.load_from_disk('index.json')
response = index.query("郡道美玲の最近の活動について教えてください。")
print(response)
