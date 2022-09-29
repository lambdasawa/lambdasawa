package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"time"

	"github.com/go-sql-driver/mysql"
)

func main() {
	jst, err := time.LoadLocation("Asia/Tokyo")
	if err != nil {
		panic(err)
	}

	db, err := sql.Open("mysql", (&mysql.Config{
		DBName:    "app",
		User:      "root",
		Passwd:    "root",
		Addr:      "127.0.0.1:3306",
		Net:       "tcp",
		ParseTime: true,
		Collation: "utf8mb4_bin",
		Loc:       jst,
	}).FormatDSN())
	if err != nil {
		panic(err)
	}

	http.HandleFunc("/safe", func(w http.ResponseWriter, r *http.Request) {
		ctx := r.Context()

		id := r.URL.Query().Get("id")

		row := db.QueryRowContext(ctx, "select name from users where id = ?", id)
		if err := row.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		var name string
		if err := row.Scan(&name); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		fmt.Fprintf(w, "Hello, %q", name)
	})

	http.HandleFunc("/unsafe", func(w http.ResponseWriter, r *http.Request) {
		ctx := r.Context()

		id := r.URL.Query().Get("id")

		query := fmt.Sprintf("select name from users where id = %s", id)

		row := db.QueryRowContext(ctx, query)
		if err := row.Err(); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		var name string
		if err := row.Scan(&name); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		fmt.Fprintf(w, "Hello, %q", name)
	})

	payload := url.Values{"id": []string{"1 and extractvalue(0x0a,concat(0x0a,(select password from users where id = 1)))"}}.Encode()

	log.Printf("curl http://localhost:8080/safe?%s", payload)
	log.Printf("curl http://localhost:8080/unsafe?%s", payload)

	log.Fatal(http.ListenAndServe(":8080", nil))
}
