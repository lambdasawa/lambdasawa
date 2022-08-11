# GraphQL

- [Syntax](https://graphql.org/learn/queries/)

TODO

## [Hasura](https://hasura.io/)

TODO

## [AWS AppSync](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/what-is-appsync.html)

TODO

## [StepZen](https://stepzen.com/)

TODO

## [graphqurl](https://github.com/hasura/graphqurl)

GraphQL を扱う CLI クライアント。

```sh
gq --introspect https://api.spacex.land/graphql -H 'Content-Type: application/json'
```

```sh
gq -i https://api.spacex.land/graphql
```

```sh
gq https://api.spacex.land/graphql/ -H 'Content-Type: application/json' \
  -q 'query Foo { dragons { id } }'
```

```sh
gq https://api.spacex.land/graphql/ -H 'Content-Type: application/json' \
  -q 'query Foo($dragonId: ID!) { dragon(id: $dragonId) { id name } }' \
  -v 'dragonId=dragon2'
```

## [Insomnia](https://insomnia.rest/)

GUIのHTTPクライアント。

---

- [awesome-graphql](https://github.com/chentsulin/awesome-graphql)
