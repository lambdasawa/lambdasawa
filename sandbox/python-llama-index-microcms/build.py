import os
import requests
from llama_index import GPTSimpleVectorIndex, Document
from llama_index.readers.base import BaseReader

class MicroCMSReader(BaseReader):
    def __init__(self, **kwargs):
      self.api_key = kwargs['api_key']
      pass

    def load_data(self, **kwargs):
        service = kwargs['service']
        api = kwargs['api']
        field_name = kwargs['field_name']

        r = requests.get(f'https://{service}.microcms.io/api/v1/{api}/', headers={
          'x-microcms-api-key': self.api_key
        })

        documents = []

        for content in r.json()['contents']:
          documents.append(Document(content[field_name]))

        return documents

documents = MicroCMSReader(api_key = os.getenv('MICROCMS_API_KEY')).load_data(
  service = os.getenv('MICROCMS_SERVICE'),
  api = os.getenv('MICROCMS_API'),
  field_name = 'content'
)
index = GPTSimpleVectorIndex.from_documents(documents)
index.save_to_disk('index.json')
