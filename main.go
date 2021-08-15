package main

import (
	"fmt"
	"log"
	"net/http"
)

var version string

func main() {

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		version = "2.3"
		fmt.Fprintln(w, "Hello World" ,version)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
