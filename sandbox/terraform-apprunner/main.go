package main

import (
	"io"
	"log"
	"net/http"
	"time"
)

func main() {
	helloHandler := func(w http.ResponseWriter, req *http.Request) {
		time.Sleep(time.Second)
		io.WriteString(w, "Hello, world!!\n")
	}

	http.HandleFunc("/hello", helloHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
