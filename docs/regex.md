# 正規表現

- <https://github.com/aloisdg/awesome-regex>
- <https://www.regexplanet.com/cookbook/index.html>
- <https://www.regexplanet.com/support/index.html>

## visualization

- [正規表現チェックツール - Kaizen Platform](https://docs.kaizenplatform.net/ja/regexp/)
  - マッチさせたい文字列、マッチさせたくない文字列、正規表現を入力するとそれらがマッチしたか表示してくれる
  - 全部期待通りなら全部緑に表示される
  - マッチさせたいのにマッチしなかったか、逆にマッチさせたくないのにマッチしたなら赤く表示される
  - 日本語
- [regex101](https://regex101.com/)
  - 正規表現とテキストを入力すると、どの部分にマッチしたか表示してくれる
  - 書いた正規表現の解説が表示される
- [RegExr](https://regexr.com/)
  - 正規表現とテキストを入力すると、どの部分にマッチしたか表示してくれる
  - 正規表現の説明がグラフィカルで見やすい
- [Debuggex](https://www.debuggex.com)
  - 正規表現を入力すると syntax diagram を表示してくれる
  - テキスト上のカーソルに合わせてその文字が syntax diagram のどこに位置するか表示してくれる
- [Regulex](https://jex.im/regulex)
  - 正規表現を入力すると syntax diagram を表示してくれる
  - カラフルで分かりやすい
- [RegEx to Strings](https://www.wimpyprogrammer.com/regex-to-strings)
  - 正規表現を入力するとそれにマッチする文字列を生成してくれる

## generators

### grex

- [github](https://github.com/pemistahl/grex)
- コマンドライン引数で受け取った文字列にマッチする正規表現を生成してくれるコマンド。

使用例

```txt
$ grex microCMS MicroCMS microcms Microcms
^[Mm]icro(?:CMS|cms)$
```

## autoregex.xyz

- <https://www.autoregex.xyz/>
- 英語で正規表現の説明を書くと正規表現を生成してくれるサイト
- GPT-3

## crossword

- <https://regexcrossword.com/>
- <https://jimbly.github.io/regex-crossword/>

## JavaScript

- <https://developer.mozilla.org/ja/docs/Web/JavaScript/Guide/Regular_Expressions>
- <https://www.npmjs.com/package/re2>

## Go

- <https://pkg.go.dev/regexp>

## Ruby

- <https://docs.ruby-lang.org/ja/latest/doc/spec=2fregexp.html>
- <https://docs.ruby-lang.org/ja/latest/class/Regexp.html>

## omake

- [正規表現の落とし穴（ReDoS - Regular Expressions DoS）](https://qiita.com/prograti/items/9b54cf82a08302a5d2c7)
- [Regex Nodes](https://johannesvollmer.com/regex-nodes/)
- [Nodeexpr](https://www.nodexr.net/)
- [Regex Previewer](https://marketplace.visualstudio.com/items?itemName=chrmarti.regex)
- [Regex Viz](https://regex-vis.com/)
- [Regexper](https://regexper.com)
