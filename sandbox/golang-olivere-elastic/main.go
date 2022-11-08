package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"

	"github.com/davecgh/go-spew/spew"
	"github.com/olivere/elastic/v7"
)

type (
	Tweet struct {
		ID      int    `json:"id"`
		Message string `json:"message"`
	}
)

func main() {
	if err := run(context.Background()); err != nil {
		panic(err)
	}
}

func run(ctx context.Context) error {
	client, err := elastic.NewClient(elastic.SetSniff(false))
	if err != nil {
		return err
	}

	const indexName = "tweets"

	for i := 0; i < 100; i++ {
		tweet := Tweet{
			ID:      i,
			Message: fmt.Sprintf("message %d", i),
		}

		_, err := client.Index().
			Index(indexName).
			Id(fmt.Sprintf("%d", i)).
			BodyJson(tweet).
			Do(ctx)

		if err != nil {
			return err
		}
	}

	{
		bulkRequest := client.Bulk()
		bulkRequest = bulkRequest.Add(elastic.NewBulkDeleteRequest().Index(indexName).Id("13"))
		bulkRequest = bulkRequest.Add(elastic.NewBulkDeleteRequest().Index(indexName).Id("14"))
		bulkRequest = bulkRequest.Add(elastic.NewBulkDeleteRequest().Index(indexName).Id("15"))
		bulkRequest = bulkRequest.Add(elastic.NewBulkCreateRequest().Index(indexName).Id("13").Doc(&Tweet{ID: 13, Message: "new message 13"}))
		bulkRequest = bulkRequest.Add(elastic.NewBulkUpdateRequest().Index(indexName).Id("16").Doc(&Tweet{ID: 16, Message: "new message 16"}))
		bulkRequest = bulkRequest.Refresh("true")

		bulkResponse, err := bulkRequest.Do(ctx)
		if err != nil {
			return err
		}

		spew.Dump(bulkResponse)
	}

	{
		res, err := client.Search().
			Index(indexName).
			Query(elastic.NewRangeQuery("id").Gte(10).Lt(20)).
			Do(ctx)
		if err != nil {
			return err
		}

		for _, hit := range res.Hits.Hits {
			source, err := hit.Source.MarshalJSON()
			if err != nil {
				return err
			}

			tweet := Tweet{}
			if err := json.NewDecoder(bytes.NewBuffer(source)).Decode(&tweet); err != nil {
				return err
			}

			spew.Dump(tweet)
		}
	}

	{
		res, err := client.Count(indexName).Do(ctx)
		if err != nil {
			return err
		}

		spew.Dump(res)
	}

	return nil
}
