# JavaScript Unicode

このページでは Unicode, UTF-16 に関連した直感と反する JavaScript のコード例と、そのコードでどのようなことが起きているのかを簡潔に説明します。
末尾に参考リンクを載せてあるので、より詳しい説明はそちらを確認してください。

## サロゲートペア (surrogate pair)

```sh
$ node -v
v17.3.1
$ node
> "吉野家".length
3
> "𠮷野家".length
4
```

JavaScript は UTF-16 を内部のエンコーディングとして使っている。
`吉` は `U+5409` 、 `𠮷(つちよし)` は `U+20BB7` というコードポイントが割り当てられている。
前者は 16bit で収まるが、後者は 16bit で収まらないため、エンコーディングを工夫する必要がある。
その工夫が今回の例で言うと `U+20BB7` というコードポイントを 2 つのコードユニットに分割してエンコーディングすること。
これがサロゲートペアと呼ばれている。

`String.charCodeAt` でコードユニットが取得できる。
以下のコードで 1 文字ごとに 1 つ目のコードユニットと 2 つ目のコードユニットを確認する。

```sh
$ node
> Array.from("吉野家").map(c => [c.charCodeAt(0).toString(16), c.charCodeAt(1).toString(16)])
[ [ '5409', 'NaN' ], [ '91ce', 'NaN' ], [ '5bb6', 'NaN' ] ]
> Array.from("𠮷野家").map(c => [c.charCodeAt(0).toString(16), c.charCodeAt(1).toString(16)])
[ [ 'd842', 'dfb7' ], [ '91ce', 'NaN' ], [ '5bb6', 'NaN' ] ]
```

`𠮷(つちよし)` のみ 2 つ目のコードユニットが存在していて、サロゲートペアが使われていることが分かる。

ちなみに `String.codePintAt` で分割前のコードポイントが取得できる。

```sh
$ node
> Array.from("吉野家").map(c => c.codePointAt(0).toString(16))
[ '5409', '91ce', '5bb6' ]
> Array.from("𠮷野家").map(c => c.codePointAt(0).toString(16))
[ '20bb7', '91ce', '5bb6' ]
```

サロゲートペアで分割されたコードユニットは以下の範囲で表される。

- U+D800 ~ U+DBFF
- U+DC00 ~ U+DFFF

JavaScript の `String.length` はコードユニット数を返すので、サロゲートペアが使われると見た目より多い数値が返される。

## 異体字 (variant)、 異体字セレクタ (variation selector)

```sh
$ node
> "葛飾区".length
3
> "葛󠄀城市".length
5
```

意味は同じだが見た目が違うような文字を 2 つのコードポイントで表すことがある。
1 つ目のコードポイントがベースとなる文字で、2 つ目のコードポイントがそのバリエーションを指定するもの。
この 2 つ目のコードポイントが異体字セレクタと呼ばれている。

`Array.from` を使うとコードポイントごとに文字列を分割できる。

```sh
$ node
> Array.from("葛飾区")
[ '葛', '飾', '区' ]
> Array.from("葛󠄀城市")
[ '葛', '󠄀', '城', '市' ]
```

葛城市の 葛 と 城の間にある文字が異体字セレクタとなっている。

```sh
$ node
> Array.from("葛󠄀城市").map(c => c.codePointAt(0).toString(16))
[ '845b', 'e0100', '57ce', '5e02' ]
```

この異体字セレクタは以下の範囲で表される。

- U+180B ~ U+180D
- U+FE00 ~ U+FE0F
- U+E0100 ~ U+E01EF

今回使われている異体字セレクタのコードポイントは U+E0100 であり 16bit で表せないので、この異体字セレクタがサロゲートペアで表現される。

よって `"葛城市".length` 以下の合計で `5` となる。

- 葛 (1)
- 葛の異体字セレクタ (2)
- 城 (1)
- 市 (1)
- 1 + 2 + 1 + 1 = 5

## 合字、リガチャ (ligature)

```sh
$ node
> const chars = ["パ", "\u30CF\u309A"]
> chars
[ 'パ', 'パ' ]
> chars.map(c => c.length)
[ 1, 2 ]
```

異体字セレクタとはまた別の概念で、2 つのコードポイントを使って一つの文字を表す仕組みがある。

## 正規化 (normalize)

前述の合字を上手く扱うために正規化という処理が定められており、JavaScript では `String.normalize` として実装されている。

```sh
$ node
> const chars = ["パ", "\u30CF\u309A"]
> chars
[ 'パ', 'パ' ]
> chars.map(c => c.length)
[ 1, 2 ]
> chars.map(c => c.normalize().length)
[ 1, 1 ]
```

<http://www.unicode.org/charts/normalization/>

## Transformation Collisions

```sh
$ node
> const gmailA = "gmaıl.com"
> const gmailB = "gmail.com"
> gmailA.toUpperCase() == gmailB.toUpperCase()
true
> gmailA.toLowerCase() == gmailB.toLowerCase()
false
```

`a.toUpperCase() === b.toUpperCase()` が `true` なら `a.toLowerCase() === b.toLowerCase()` も `true` になりそうだが、そうとは限らない。
必ずしも文字の upper と lower の関係は一対一にはなっていない。
`ı` と `i` はどちらも別の文字だが、 `toUpperCase` をするとどちらも `I` になる。
逆に `I` に `toLowerCase` をすると `i` になるが、 `ı` になることはない。

これを区別できていないがゆえにセキュリティ問題に繋がったこともある。
<https://dev.to/jagracey/hacking-github-s-auth-with-unicode-s-turkish-dotless-i-460n>

<http://www.unicode.org/charts/case/>

## ZWJ (Zero Width Joiner)

```sh
$ node
> "👨‍👩‍👧‍👧".length
11
```

複数の文字を繋げて 1 つの文字を表すためのコードポイントも存在している。
上記の家族の絵文字は 4 つの絵文字を Zero Width Joiner (`U+200D`) という文字を 3 回使って結合したものとなっている。

```sh
$ node
> Array.from("👨‍👩‍👧‍👧")
[ '👨', '‍', '👩', '‍', '👧', '‍', '👧' ]
Array.from("👨‍👩‍👧‍👧").map(c => c.codePointAt(0).toString(16))
[ '1f468', '200d', '1f469', '200d', '1f467', '200d', '1f467' ]
```

この `length` が 11 になるのは以下のような計算の結果。

- 👨 サロゲートペアなので 2 とカウント
- Zero Width Joiner として 1 カウント
- 👩 サロゲートペアなので 2 とカウント
- Zero Width Joiner として 1 とカウント
- 👧 サロゲートペアなので 2 とカウント
- Zero Width Joiner として 1 とカウント
- 👧 サロゲートペアなので 2 とカウント
- 2 + 1 + 2 + 1 + 2 + 1 + 2 = 11

<https://emojipedia.org/emoji-zwj-sequence/>

## 参考リンク

- <https://blog.jxck.io/entries/2017-03-02/unicode-in-javascript.html>
- <https://engineering.linecorp.com/ja/blog/the-7-ways-of-counting-characters/>
- <https://github.com/jagracey/Awesome-Unicode>
- 検索系
  - <https://graphemica.com/>
  - <https://codepoints.net/>
  - <https://unicode-table.com/en/>
  - <https://shapecatcher.com/>
  - <https://util.unicode.org/UnicodeJsps/character.jsp>
- 絵文字の検索系
  - <https://emojipedia.org/>
  - <http://emojitracker.com/>
  - <http://www.unicode.org/emoji/charts/full-emoji-list.html>
- <https://github.com/jagracey/Awesome-Unicode#readme>
- <https://github.com/Codepoints/awesome-codepoints#readme>
