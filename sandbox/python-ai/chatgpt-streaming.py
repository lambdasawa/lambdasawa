import os
import sys
import openai

openai.api_key = os.getenv("OPENAI_API_KEY")

response = openai.Completion.create(
    model="text-davinci-003",
    prompt="お寿司とおにぎりの違いを教えて",
    stream=True,
    temperature=0.9,
    max_tokens=4000,
)
for res in response:
    sys.stdout.write(res.choices[0].text)
    sys.stdout.flush()
print()
