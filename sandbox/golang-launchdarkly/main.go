package main

import (
	"log"
	"os"
	"time"

	"gopkg.in/launchdarkly/go-sdk-common.v2/lduser"
	ld "gopkg.in/launchdarkly/go-server-sdk.v5"
)

func main() {
	ldClient, err := ld.MakeClient(os.Getenv("SDK_KEY"), 5*time.Second)
	if err != nil {
		panic(err)
	}
	defer ldClient.Close()

	if !ldClient.Initialized() {
		panic("SDK failed to initialize")
	}

	user := lduser.NewUserBuilder("test").Name("test test").Build()

	state := ldClient.AllFlagsState(user)
	for key := range state.ToValuesMap() {
		log.Printf("%-20s: %v", key, state.GetValue(key))
	}

	value, err := ldClient.StringVariation("targeting-off", user, "none")
	if err != nil {
		panic(err)
	}
	log.Println(value)
}
