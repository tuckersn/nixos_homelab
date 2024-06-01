package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("Hello World")

	fmt.Println("API started on http://localhost:3000")

	for {
		time.Sleep(time.Second)
	}
}
