package main

import (
	"crypto/hmac"
	"crypto/sha1"
	"encoding/base32"
	"encoding/binary"
	"fmt"
	"math"
	"os"
	"time"
)

// https://www.lambdasawa.net/posts/google-authenticator-golang/
func main() {
	key := os.Args[1]

	keyBytes, err := base32.StdEncoding.DecodeString(key)
	if err != nil {
		panic(err)
	}

	startLoop(func() (uint32, error) {
		return generateTOTP(keyBytes, 6, 30, 0, uint64(time.Now().Unix()))
	})
}

func startLoop(f func() (uint32, error)) {
	var beforeTOTP uint32
	for {
		totp, err := f()
		if err != nil {
			panic(err)
		}

		if totp != beforeTOTP {
			fmt.Printf("%06d\n", totp)
		}

		beforeTOTP = totp

		time.Sleep(time.Second)
	}
}

func generateTOTP(key []byte, digit uint, intervalTs uint64, baseTs uint64, currentTs uint64) (uint32, error) {
	count := (currentTs - baseTs) / intervalTs

	data := make([]byte, 8)
	binary.BigEndian.PutUint64(data, count)

	result, err := generateHOTP(key, data, digit)
	if err != nil {
		return 0, err
	}

	return result, err
}

func generateHOTP(key []byte, data []byte, digit uint) (uint32, error) {
	mac := hmac.New(sha1.New, []byte(key))
	if _, err := mac.Write([]byte(data)); err != nil {
		return 0, err
	}
	hmacBytes := mac.Sum(nil)

	offset := hmacBytes[len(hmacBytes)-1] & 0xF

	number := binary.BigEndian.Uint32(hmacBytes[offset:offset+4]) & 0x7FFFFFFF

	result := uint32(number) % uint32(math.Pow(10, float64(digit)))

	return result, nil
}
