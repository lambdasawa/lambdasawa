# struct generator

- [transform.tools](https://transform.tools/json-to-go)
- [quicktype](https://app.quicktype.io/)
- [openapi-generator](https://github.com/OpenAPITools/openapi-generator)
- [protoc](https://developers.google.com/protocol-buffers/docs/gotutorial)
- [gqlgen](https://github.com/99designs/gqlgen)
- [sqlboiler](https://github.com/volatiletech/sqlboiler)

## quicktype

JSON から Go の構造体、 TypeScript の interface などを生成するコマンド。

```sh
$ curl -sSL https://httpbin.org/json | npx quicktype --lang go --just-types
type TopLevel struct {
        Slideshow Slideshow `json:"slideshow"`
}

type Slideshow struct {
        Author string  `json:"author"`
        Date   string  `json:"date"`
        Slides []Slide `json:"slides"`
        Title  string  `json:"title"`
}

type Slide struct {
        Title string   `json:"title"`
        Type  string   `json:"type"`
        Items []string `json:"items,omitempty"`
}
```
