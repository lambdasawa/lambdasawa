package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

type aggregator struct {
	totalAmount map[string]int64
}

func (a *aggregator) add(channelID string, purchaseAmount string) error {
	purchaseAmountWithoutSymbol := regexp.MustCompile(`[¥,]`).ReplaceAllString(purchaseAmount, "")

	amount, err := strconv.ParseInt(purchaseAmountWithoutSymbol, 10, 64)
	if err != nil {
		return fmt.Errorf("parse purchase amount: %w", err)
	}

	a.totalAmount[channelID] += amount

	return nil
}

func (a *aggregator) show() {
	lines := make([]aggregationReportLine, 0)

	for id, amount := range a.totalAmount {
		lines = append(lines, aggregationReportLine{
			channelID: id,
			amount:    amount,
		})
	}

	sort.Slice(lines, func(i, j int) bool {
		return lines[i].amount > lines[j].amount
	})

	for i, line := range lines {
		fmt.Printf("%4d %v %8d\n", i+1, line.channelID, line.amount)
	}
}

type aggregationReportLine struct {
	channelID string
	amount    int64
}

func main() {
	if err := run(); err != nil {
		panic(err)
	}
}

func run() error {
	liveChats, err := loadLiveChatFiles()
	if err != nil {
		return fmt.Errorf("load live chat files: %w", err)
	}

	aggregator := aggregator{
		totalAmount: map[string]int64{},
	}

	for _, chat := range liveChats {
		for _, action := range chat.ReplayChatItemAction.Actions {
			if action.AddChatItemAction == nil {
				continue
			}

			item := action.AddChatItemAction.Item

			if sticker := item.LiveChatPaidStickerRenderer; sticker != nil {
				if err := aggregator.add(sticker.AuthorExternalChannelID, sticker.PurchaseAmountText.SimpleText); err != nil {
					log.Println(err)
				}
			}

			if chat := item.LiveChatPaidMessageRenderer; chat != nil {
				if err := aggregator.add(chat.AuthorExternalChannelID, chat.PurchaseAmountText.SimpleText); err != nil {
					log.Println(err)
				}
			}
		}
	}

	aggregator.show()

	return nil
}

func loadLiveChatFiles() ([]LiveChat, error) {
	paths, err := loadLiveChatJSONPaths()
	if err != nil {
		return nil, fmt.Errorf("load live chat jsonp paths: %v", err)
	}

	liveChats := make([]LiveChat, 0)

	for _, path := range paths {
		liveChatFile, err := loadLiveChatFile(path)
		if err != nil {
			return nil, fmt.Errorf("load live chat file(%s): %w", path, err)
		}

		liveChats = append(liveChats, liveChatFile...)
	}

	return liveChats, nil
}

func loadLiveChatJSONPaths() ([]string, error) {
	const liveChatJSONsDir = "../downloader"

	files, err := ioutil.ReadDir(liveChatJSONsDir)
	if err != nil {
		return nil, fmt.Errorf("read downloader dir: %w", err)
	}

	paths := make([]string, 0)

	for _, file := range files {
		filePath := filepath.Join("../downloader", file.Name())

		if !isFilenameLiveChatJSON(filePath) {
			continue
		}

		paths = append(paths, filePath)
	}

	return paths, nil
}

func isFilenameLiveChatJSON(fileName string) bool {
	return strings.HasSuffix(fileName, ".live_chat.json")
}

func loadLiveChatFile(filePath string) (LiveChatFile, error) {
	var liveChatFile LiveChatFile

	file, err := os.Open(filePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	decoder := json.NewDecoder(file)

	for {
		var liveChat LiveChat

		if err := decoder.Decode(&liveChat); err != nil {
			if errors.Is(err, io.EOF) {
				break
			}

			return nil, err
		}

		liveChatFile = append(liveChatFile, liveChat)
	}

	return liveChatFile, nil
}
