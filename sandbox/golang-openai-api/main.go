package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
)

func main() {
	if err := run(); err != nil {
		panic(err)
	}
}

func run() error {
	reqBody := &bytes.Buffer{}

	if err := json.NewEncoder(reqBody).Encode(&CompletionRequest{
		Model:     "text-davinci-003",
		Prompt:    "golang で bytes の channel を少しずつ string にするには？",
		MaxTokens: 2048,
		Stream:    true,
	}); err != nil {
		return fmt.Errorf("encode request: %w", err)
	}

	httpReq, err := http.NewRequest("POST", "https://api.openai.com/v1/completions", reqBody)
	if err != nil {
		return fmt.Errorf("make request: %w", err)
	}

	httpReq.Header.Set("Content-Type", "application/json")
	httpReq.Header.Set("Authorization", fmt.Sprintf("Bearer %s", os.Getenv("API_KEY")))

	httpRes, err := http.DefaultClient.Do(httpReq)
	if err != nil {
		return fmt.Errorf("send request: %w", err)
	}

	scanner := bufio.NewScanner(httpRes.Body)

	for scanner.Scan() {
		line := scanner.Text()

		data := strings.TrimSpace(strings.TrimPrefix(line, "data:"))

		if data == "[DONE]" {
			return nil
		}
		if data == "" {
			continue
		}

		res := &CompletionResponse{}

		if err := json.NewDecoder(strings.NewReader(data)).Decode(&res); err != nil {
			return fmt.Errorf("decode response: %w", err)
		}

		fmt.Print(res.Choices[0].Text)
	}

	return nil
}
