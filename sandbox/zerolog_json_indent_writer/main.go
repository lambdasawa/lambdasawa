package main

import (
	"bytes"
	"encoding/json"
	"io"
	"log"
	"os"
)

type JSONIndentWriter struct {
	Out io.Writer
}

func (w *JSONIndentWriter) Write(p []byte) (int, error) {
	buf := new(bytes.Buffer)
	if err := json.Indent(buf, p, "", "  "); err != nil {
		return 0, err
	}

	if _, err := buf.WriteTo(w.Out); err != nil {
		return 0, err
	}

	return 0, nil
}

func main() {
	log.Logger = log.Output(&JSONIndentWriter{Out: os.Stdout})
}
