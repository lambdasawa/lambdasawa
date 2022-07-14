# golang

## IDE

<https://www.jetbrains.com/ja-jp/go/>

## linter

<https://golangci-lint.run/>

## best practice

- [Go Code Review Comments](https://gist.github.com/knsh14/0507b98c6b62959011ba9e4c310cd15d)
- [uber-style-guide-ja](https://github.com/knsh14/uber-style-guide-ja/blob/master/guide.md#%E5%B0%8E%E5%85%A5)
- [Effective Go](https://go.dev/doc/effective_go)
- [SliceTricks](https://github.com/golang/go/wiki/SliceTricks)
- [Goのテストに入門してみよう！](https://future-architect.github.io/articles/20200601/)
- [Goにおけるポインタの使いどころ](https://zenn.dev/uji/articles/f6ab9a06320294146733)
- [Go Cheat Sheet](https://github.com/a8m/golang-cheat-sheet)

## total coverage

```sh
go test ./... -cover -coverpkg=./... | grep -v 'no test files' | sed -E 's/.*coverage: (.+)%.*/\\1/' | paste -s -d+ - | bc
```

## render dependency graph

```sh
godepgraph -p $(cat go.sum | awk '{print $1}' | sort -u | paste -s -d, -) -novendor -s $(go list) | dot -Tpng -o godepgraph.png
```

## lib

- <https://github.com/cockroachdb/errors>
