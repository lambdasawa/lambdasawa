package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/dghubble/go-twitter/twitter"
	"github.com/dghubble/oauth1"
	"github.com/guregu/dynamo"
	jd "github.com/josephburnett/jd/lib"
)

var (
	screenName = os.Getenv("TWITTER_SCREEN_NAME")

	slackWebhook = os.Getenv("SLACK_WEBHOOK")

	tableName = "oshimon"
)

type User struct {
	UserID    uint64        `dynamo:"userId"`
	Timestamp uint64        `dynamo:"timestamp"`
	TTL       uint64        `dynamo:"ttl"`
	User      *twitter.User `dynamo:"user"`
}

func main() {
	log.SetFlags(log.Ldate | log.Ltime | log.Lshortfile)
	log.SetOutput(os.Stdout)

	lambda.Start(HandleRequest)

}

func HandleRequest(ctx context.Context) error {
	if err := run(); err != nil {
		log.Println("Failure")
		log.Panicln(err)
	}

	log.Println("Success")

	return nil
}

func run() error {
	// init twitterH
	config := oauth1.NewConfig(os.Getenv("TWITTER_API_KEY"), os.Getenv("TWITTER_API_KEY_SECRET"))
	token := oauth1.NewToken(os.Getenv("TWITTER_ACCESS_TOKEN"), os.Getenv("TWITTER_ACCESS_TOKEN_SECRET"))
	httpClient := config.Client(oauth1.NoContext, token)
	twitterClient := twitter.NewClient(httpClient)

	// init aws
	sess := session.Must(session.NewSession())
	db := dynamo.New(sess)
	table := db.Table(tableName)

	if err := check(twitterClient, table); err != nil {
		return fmt.Errorf("check: %v", err)
	}

	return nil
}

func check(twitterClient *twitter.Client, table dynamo.Table) error {
	log.Println("fetch user from twitter")
	twitterUser, err := fetchUserFromTwitter(twitterClient)
	if err != nil {
		return fmt.Errorf("fetch user from Twitter: %v", err)
	}

	log.Println("put user to db")
	dbUser, err := putUserToDB(table, twitterUser)
	if err != nil {
		return fmt.Errorf("put user to DB: %v", err)
	}

	log.Println("load user from db")
	users, err := loadUsersFromDB(table, dbUser)
	if err != nil {
		return fmt.Errorf("load users from DB: %v", err)
	}

	log.Println("render diff")
	diff, err := renderDiff(users[1].User, users[0].User)
	if err != nil {
		return fmt.Errorf("render diff: %v", err)
	}

	if len(diff) != 0 {
		log.Println("post slack")
		if err := postSlack(diff); err != nil {
			return fmt.Errorf("post slack: %v", err)
		}
	}

	return nil
}

func fetchUserFromTwitter(client *twitter.Client) (*twitter.User, error) {
	user, _, err := client.Users.Show(&twitter.UserShowParams{ScreenName: screenName})
	if err != nil {
		return nil, fmt.Errorf("fetch user: %v", err)
	}

	user.FollowersCount = 0
	user.FriendsCount = 0
	user.ListedCount = 0
	user.Status.RetweetCount = 0
	user.Status.FavoriteCount = 0
	if user.Status.RetweetedStatus != nil {
		user.Status.RetweetedStatus.FavoriteCount = 0
		user.Status.RetweetedStatus.RetweetCount = 0
	}

	return user, nil
}

func putUserToDB(table dynamo.Table, user *twitter.User) (*User, error) {
	now := time.Now()
	timestamp := now.UnixMilli()
	ttl := now.Add(time.Hour * 24 * 7).Unix()

	dbUser := User{
		UserID:    uint64(user.ID),
		Timestamp: uint64(timestamp),
		TTL:       uint64(ttl),
		User:      user,
	}

	if err := table.Put(&dbUser).Run(); err != nil {
		return nil, fmt.Errorf("put user: %v", err)
	}

	return &dbUser, nil
}

func loadUsersFromDB(table dynamo.Table, dbUser *User) ([]*User, error) {
	users := make([]*User, 0)

	if err := table.
		Get("userId", dbUser.User.ID).
		Range("timestamp", dynamo.LessOrEqual, dbUser.Timestamp).
		Order(dynamo.Descending).
		Limit(2).
		All(&users); err != nil {
		return nil, fmt.Errorf("fetch users from db: %v", err)
	}

	return users, nil
}

func renderDiff(a, b *twitter.User) (string, error) {
	read := func(u *twitter.User) (jd.JsonNode, error) {
		buf := new(bytes.Buffer)
		if err := json.NewEncoder(buf).Encode(u); err != nil {
			return nil, fmt.Errorf("encode user: %v", err)
		}

		return jd.ReadJsonString(buf.String())
	}

	aJson, err := read(a)
	if err != nil {
		return "", fmt.Errorf("read user A: %v", err)
	}

	bJson, err := read(b)
	if err != nil {
		return "", fmt.Errorf("read user B: %v", err)
	}

	return aJson.Diff(bJson).Render(), nil
}

func postSlack(text string) error {
	req := map[string]interface{}{
		"text": "oshimon",
		"attachments": []map[string]interface{}{
			{
				"text": fmt.Sprintf("```\n%s\n```", text),
			},
		},
	}
	reqBytes, err := json.Marshal(req)
	if err != nil {
		return fmt.Errorf("serialize request: %v", err)
	}

	if _, err := http.Post(slackWebhook, "application/json", bytes.NewBuffer(reqBytes)); err != nil {
		return fmt.Errorf("send request: %v", err)
	}

	return nil
}
