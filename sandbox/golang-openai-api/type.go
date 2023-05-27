package main

type CompletionRequest struct {
	Model       string      `json:"model,omitempty"`
	Prompt      string      `json:"prompt,omitempty"`
	MaxTokens   int64       `json:"max_tokens,omitempty"`
	Temperature int64       `json:"temperature,omitempty"`
	TopP        int64       `json:"top_p,omitempty"`
	N           int64       `json:"n,omitempty"`
	Stream      bool        `json:"stream,omitempty"`
	Logprobs    interface{} `json:"logprobs,omitempty"`
	Stop        string      `json:"stop,omitempty"`
}

type CompletionResponse struct {
	ID      string   `json:"id"`
	Object  string   `json:"object"`
	Created int64    `json:"created"`
	Model   string   `json:"model"`
	Choices []Choice `json:"choices"`
	Usage   Usage    `json:"usage"`
}

type Choice struct {
	Text         string      `json:"text"`
	Index        int64       `json:"index"`
	Logprobs     interface{} `json:"logprobs"`
	FinishReason string      `json:"finish_reason"`
}

type Usage struct {
	PromptTokens     int64 `json:"prompt_tokens"`
	CompletionTokens int64 `json:"completion_tokens"`
	TotalTokens      int64 `json:"total_tokens"`
}
