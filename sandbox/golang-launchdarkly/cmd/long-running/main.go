package main

import (
	"log"
	"os"
	"time"

	"gopkg.in/launchdarkly/go-sdk-common.v2/lduser"
	ld "gopkg.in/launchdarkly/go-server-sdk.v5"
)

func main() {
	start := time.Now()
	ldClient, err := ld.MakeClient(os.Getenv("SDK_KEY"), 5*time.Second)
	if err != nil {
		panic(err)
	}
	defer ldClient.Close()

	if !ldClient.Initialized() {
		panic("SDK failed to initialize")
	}
	log.Printf("init took %s", time.Since(start))

	user := lduser.NewUserBuilder("foo").Name("Foo").Build()

	for {
		measure("get one flag with user", func() {
			if v, err := ldClient.BoolVariation("server-only-flag", user, false); err != nil {
				panic(err)
			} else {
				println(v)
			}
		})

		time.Sleep(time.Second)
	}
}

func measure(label string, f func()) {
	start := time.Now()

	f()

	log.Printf("%s took %s", label, time.Since(start))
}
