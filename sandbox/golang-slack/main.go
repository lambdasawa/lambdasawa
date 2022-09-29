package main

import (
	"os"
	"strings"

	"github.com/slack-go/slack"
)

func main() {
	api := slack.New(os.Getenv("SLACK_TOKEN"))

	if _, _, err := api.PostMessage(
		"sandbox",
		slack.MsgOptionBlocks(
			slack.NewSectionBlock(
				slack.NewTextBlockObject(slack.PlainTextType, "Hello, world!", false, false),
				[]*slack.TextBlockObject{
					{
						Type: "mrkdwn",
						Text: strings.Join([]string{"*hello*", "`world`"}, "\n"),
					},
					{
						Type: "mrkdwn",
						Text: strings.Join([]string{"*lambda*", "`sawa`"}, "\n"),
					},
					{
						Type: "mrkdwn",
						Text: strings.Join([]string{"*tsubasa*", "`irisawa`"}, "\n"),
					},
				},
				nil,
			),
		),
	); err != nil {
		panic(err)
	}
}
