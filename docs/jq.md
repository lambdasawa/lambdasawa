# jq

- [jq コマンドを使う日常のご紹介](https://qiita.com/takeshinoda@github/items/2dec7a72930ec1f658af)
- [ref](https://stedolan.github.io/jq/manual/#Basicfilters)
- [language description](https://github.com/stedolan/jq/wiki/jq-Language-Description)

## filter

```sh
$ echo '[{ "n": 1 }, { "n": 2 }, { "n": 3 }]' | jq '.[] | select(.n % 2 == 0)'
{
  "n": 2
}
```

## map

```sh
$ echo '[{ "n": 1 }, { "n": 2 }, { "n": 3 }]' | jq 'map(.n * 10)'
[
  10,
  20,
  30
]
```

## filter の flatten しないやつ

```sh
$ echo '[{ "n": 1 }, { "n": 2 }, { "n": 3 }]' | jq 'map(select(.n % 2 == 0))'
[
  {"n": 2}
]
```

## JSON lines を配列として読み取る

```sh
$ printf '{"foo": 1}\n{"foo": 2}' | jq -s '.'
[
  {"foo": 1},
  {"foo": 2}
]
```

## printf, format

```sh
$ echo '[{ "n": 1 }, { "n": 2 }, { "n": 3 }]' | jq 'map("n => \(.n + 1)")'
[
  "n => 2",
  "n => 3",
  "n => 4"
]
```

## 合計

```sh
$ echo '[{ "n": 1 }, { "n": 2 }, { "n": 3 }]' | jq 'map(.n) | add'
6
```

## 配列の長さ

```sh
$ echo '[{ "n": 1 }, { "n": 2 }, { "n": 3 }]' | jq 'length'
3
```

## 平均

```sh
$ echo '[{ "n": 1 }, { "n": 2 }, { "n": 3 }]' | jq 'map(.n) as $ns | ($ns | add) / ($ns | length)'
2
```

## 正規表現でフィルタリング

```sh
$ curl -sSL https://api.github.com/users/lambdasawa/repos | jq 'map(select(.name | test("lambda(?!sawa)")) | .name)'
[
  "aws-lambda-versions"
]
```

## 先頭3個

```sh
$ echo '[1,2,3,4,5,6,7,8,9,10]' | jq 'limit(3; .[])'
1
2
3
```

## 末尾3個

```sh
$ echo '[1,2,3,4,5,6,7,8,9,10]' | jq 'limit(3; reverse | .[])'
10
9
8
```

## 要素の追加と削除

```sh
$ echo '{"a": 1, "b": 2}' | jq '.foo = "bar" | del(.b)'
{
  "a": 1,
  "foo": "bar"
}
```

## 環境変数にアクセス

```sh
$ jq -nr 'env.USER'
lambdasawa
```

## コマンドラインで変数を渡す

```sh
$ jq -n --arg FOO bar '{ foo: $FOO }'
{
  "foo": "bar"
}
```

## JSONデコード

```sh
$ echo '{"data": "{\\"data\\": 1}"}' | jq '.data | fromjson'
{
  "data": 1
}
```

## URIエンコード

```sh
$ jq -nr --arg value abcあいうえお '$value | @uri'
abc%E3%81%82%E3%81%84%E3%81%86%E3%81%88%E3%81%8A
```

## fizzbuzz

```sh
jq -rn 'range(1;100+1) | if . % 15 == 0 then "fizzbuzz" elif . % 3 == 0 then "fizz" elif . % 5 == 0 then "buzz" else . end'
```

## Cookbook

EC2 をインスタンス名で絞って表示。

```sh
aws ec2 describe-instances |\
  jq -r '.Reservations[] | .Instances[] | select(.Tags[] | .Key == "Name" and .Value == "test") | .InstanceId'
```

EC2 一覧を TSV で表示する。

```sh
aws ec2 describe-instances |\
  jq -r '.Reservations[] | .Instances[] | "\(.InstanceId)\t\(.Tags[] | select(.Key == "Name") | .Value)"'
```

```sh
aws ec2 describe-instances |\
  jq -r '.Reservations[] | .Instances[] | [.InstanceId, (.Tags[] | select(.Key == "Name") | .Value)] | join("\t")'
```

```sh
aws ec2 describe-instances |\
  jq -r '.Reservations[] | .Instances[] | [.InstanceId, (.Tags[] | select(.Key == "Name") | .Value)] | @tsv'
```
