package main

import (
	"github.com/dop251/goja"

	_ "embed"
)

//go:embed bundle.js
var bundleJS string

func main() {
	runtime := goja.New()

	if err := runtime.Set("input", "foo@example.com"); err != nil {
		panic(err)
	}

	if _, err := runtime.RunString(bundleJS); err != nil {
		panic(err)
	}

	println(runtime.Get("output").String())
}
