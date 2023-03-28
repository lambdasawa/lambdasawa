import os
import openai

openai.api_key = os.getenv("OPENAI_API_KEY")

response = openai.Completion.create(
    model="text-davinci-003",
    prompt="お寿司とおにぎりの違いを教えて",
    temperature=0.9,
    max_tokens=4000,
)
print(response.choices[0].text)
