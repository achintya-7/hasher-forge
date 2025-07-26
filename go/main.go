package main

import (
	"fmt"
	"syscall/js"

	"github.com/zeebo/xxh3"
)

func main() {
	c := make(chan struct{}, 0)
	registerCallbacks()
	<-c
}

func registerCallbacks() {
	js.Global().Set("hashFile", js.FuncOf(hashFile))
}

func hashFile(this js.Value, args []js.Value) interface{} {
	if len(args) < 1 {
		js.Global().Call("console.error", "Usage: hashFile(fileData)")
		return nil
	}

	fileData := args[0]

	// Get the length of the file data
	length := fileData.Get("length").Int()
	if length == 0 {
		js.Global().Call("console.error", "File data is empty")
		return nil
	}

	// Create buffer to hold file data
	buffer := make([]byte, length)
	js.CopyBytesToGo(buffer, fileData)

	// Use a buffer of 256kb for performance
	bufferSize := 256 * 1024 // 256kb
	if length > bufferSize {
		hasher := xxh3.New()

		for offset := 0; offset < length; {
			end := offset + bufferSize
			if end > length {
				end = length
			}

			chunk := buffer[offset:end]
			if len(chunk) == 0 {
				break
			}

			_, err := hasher.Write(chunk)
			if err != nil {
				js.Global().Call("console.error", "Failed to write data to the running hash:", err.Error())
				return nil
			}

			offset += len(chunk)
		}
		finalHash := hasher.Sum64()
		fmt.Println("Hash calculated (chunked):", finalHash)
		return fmt.Sprintf("%d", finalHash)
	}

	// Calculate hash directly
	finalHash := xxh3.Hash(buffer)
	fmt.Println("Hash calculated:", finalHash)

	// Convert to string
	return fmt.Sprintf("%d", finalHash)
}
