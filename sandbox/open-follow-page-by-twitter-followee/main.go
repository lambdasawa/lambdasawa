package main

import (
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/dghubble/go-twitter/twitter"
	"github.com/dghubble/oauth1"
	"github.com/skratchdot/open-golang/open"
)

func main() {
	config := oauth1.NewConfig(
		os.Getenv("TWITTER_API_KEY"),
		os.Getenv("TWITTER_API_KEY_SECRET"),
	)
	token := oauth1.NewToken(
		os.Getenv("TWITTER_ACCESS_TOKEN"),
		os.Getenv("TWITTER_ACCESS_TOKEN_SECRET"),
	)
	httpClient := config.Client(oauth1.NoContext, token)

	client := twitter.NewClient(httpClient)

	var cursor int64
	for {
		println("call twitter api")
		time.Sleep((time.Minute))

		friends, _, err := client.Friends.List(&twitter.FriendListParams{
			ScreenName: "lambdasawa",
			Count:      100,
			Cursor:     cursor,
		})
		if err != nil {
			panic(err)
		}
		if len(friends.Users) == 0 {
			return
		}

		for _, user := range friends.Users {
			println("find", user.ScreenName)
			resp, err := http.DefaultClient.Get(fmt.Sprintf("https://zenn.dev/%s/feed", user.ScreenName))
			if err != nil {
				panic(err)
			}
			if err := resp.Body.Close(); err != nil {
				panic(err)
			}

			if resp.StatusCode >= 400 {
				continue
			}

			println("open", user.ScreenName)
			time.Sleep(time.Second)

			if err := open.Run(fmt.Sprintf("https://zenn.dev/%s", user.ScreenName)); err != nil {
				panic(err)
			}
		}

		cursor = friends.NextCursor
	}
}
