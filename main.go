package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "¡Hola desde Go en Docker!")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Servidor escuchando en el puerto 8080...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
