package main

import (
	"io/ioutil"
	"strings"

	"golang.org/x/text/encoding/japanese"
)

func main() {
	println(convertSJISToUTF8("沢"))
}

func convertSJISToUTF8(text string) string {
	reader := japanese.ShiftJIS.NewDecoder().Reader(strings.NewReader(text))
	bytes, err := ioutil.ReadAll(reader)
	if err != nil {
		panic(err)
	}
	return string(bytes)
}
