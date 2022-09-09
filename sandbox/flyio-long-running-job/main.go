package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"os"
	"time"

	"github.com/labstack/echo/v4"
)

var (
	jobs = map[string]int{}
)

func main() {
	rand.Seed(time.Now().UnixNano())

	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})

	e.GET("/jobs", func(c echo.Context) error {
		return c.JSON(http.StatusOK, jobs)
	})

	e.GET("/jobs/:id", func(c echo.Context) error {
		id := c.Param("id")

		return c.JSON(http.StatusOK, jobs[id])
	})

	e.POST("/jobs/:id", func(c echo.Context) error {
		id := c.Param("id")

		jobs[id] = 0

		go func() {
			for i := 0; i < 100; i++ {
				jobs[id] += 1
				time.Sleep(time.Second)
			}
		}()

		return c.JSON(http.StatusOK, jobs)
	})

	port := "1323"
	if v := os.Getenv("PORT"); v != "" {
		port = v
	}

	address := fmt.Sprintf(":%s", port)

	e.Logger.Fatal(e.Start(address))
}
