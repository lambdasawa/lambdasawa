package main

import (
	"encoding/json"

	"gopkg.in/yaml.v3"
)

type Foo struct {
	// Bar string
	// Bar string `json:"fizz"`
	// Bar string `yaml:"fizz"`
	Bar string `json yaml:"fizz"`
}

func main() {
	value := Foo{Bar: "bar"}

	{
		bytes, _ := json.Marshal(value)
		println(string(bytes))
	}

	{
		bytes, _ := yaml.Marshal(value)
		println(string(bytes))
	}
}
