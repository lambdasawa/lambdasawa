# JSON tools

## tools

### jq

<https://stedolan.github.io/jq/manual/>

pretty print したり独自のクエリ言語で一部の要素を抜き出したりできる。

詳しくは[こちら](./jq.md)。

### jless

<https://jless.io/user-guide.html>

vim っぽいキーバインドで JSON を閲覧できるコマンド。
シンタックスハイライトがあったり人間にとっては無益なクオートが表示されなかったり、とても人間にとって読みやすいフォーマットで表示される。

`j`, `k` でフィールドを移動して `h`, `l` で畳み込みと展開ができる。

`/` で検索ができる。

`*` で現在選択中のオブジェクトの兄弟に当たるオブジェクトの同名のフィールドの位置に移動する。

```sh
{
  "items": [
    {
      "id": 123,
      "foo": 1    // 要はここから
    },
    {
      "id": 456,
      "foo": 2    // ここに移動できるという意味
    }
  ]
}
```

`*` と同じ要領で逆向きに移動するには `#` を押す。

`yy` で選択中のノードをクリップボードにコピーできる。

### gron

<https://github.com/tomnomnom/gron>

JSON を grep しやすいテキストに変換する

```sh
$ curl -sSL "https://api.github.com/repos/lambdasawa/lambdasawa" | gron | grep owner
json.owner = {};
json.owner.avatar_url = "https://avatars.githubusercontent.com/u/9388092?v=4";
json.owner.events_url = "https://api.github.com/users/lambdasawa/events{/privacy}";
json.owner.followers_url = "https://api.github.com/users/lambdasawa/followers";
json.owner.following_url = "https://api.github.com/users/lambdasawa/following{/other_user}";
json.owner.gists_url = "https://api.github.com/users/lambdasawa/gists{/gist_id}";
json.owner.gravatar_id = "";
json.owner.html_url = "https://github.com/lambdasawa";
json.owner.id = 9388092;
json.owner.login = "lambdasawa";
json.owner.node_id = "MDQ6VXNlcjkzODgwOTI=";
json.owner.organizations_url = "https://api.github.com/users/lambdasawa/orgs";
json.owner.received_events_url = "https://api.github.com/users/lambdasawa/received_events";
json.owner.repos_url = "https://api.github.com/users/lambdasawa/repos";
json.owner.site_admin = false;
json.owner.starred_url = "https://api.github.com/users/lambdasawa/starred{/owner}{/repo}";
json.owner.subscriptions_url = "https://api.github.com/users/lambdasawa/subscriptions";
json.owner.type = "User";
json.owner.url = "https://api.github.com/users/lambdasawa";
```

`gron` して `grep` で絞ったテキストを `gron -u` で再度 JSON に戻すこともできる。

```sh
$ curl -sSL "https://api.github.com/repos/lambdasawa/lambdasawa" | gron | grep owner | gron -u
{
  "owner": {
    "avatar_url": "https://avatars.githubusercontent.com/u/9388092?v=4",
    "events_url": "https://api.github.com/users/lambdasawa/events{/privacy}",
    "followers_url": "https://api.github.com/users/lambdasawa/followers",
    "following_url": "https://api.github.com/users/lambdasawa/following{/other_user}",
    "gists_url": "https://api.github.com/users/lambdasawa/gists{/gist_id}",
    "gravatar_id": "",
    "html_url": "https://github.com/lambdasawa",
    "id": 9388092,
    "login": "lambdasawa",
    "node_id": "MDQ6VXNlcjkzODgwOTI=",
    "organizations_url": "https://api.github.com/users/lambdasawa/orgs",
    "received_events_url": "https://api.github.com/users/lambdasawa/received_events",
    "repos_url": "https://api.github.com/users/lambdasawa/repos",
    "site_admin": false,
    "starred_url": "https://api.github.com/users/lambdasawa/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/lambdasawa/subscriptions",
    "type": "User",
    "url": "https://api.github.com/users/lambdasawa"
  }
}
```

### jsondiffpatch

<https://github.com/benjamine/jsondiffpatch>

```sh
$ cat foo.json
{
  "text": "Left value"
}

$ cat bar.json
{
  "text": "Right value"
}

$ jsondiffpatch foo.json bar.json
{
  text: "Left value" => "Right value"
}
```

### jc

<https://github.com/kellyjonbrazil/jc>

`jc ls` とするとカレントディレクトリが JSON で出力される。
`jc ps` とするとプロセス一覧が JSON で出力される。
サポートされているコマンドは他にも多数ある。

`/etc/hosts`, `/etc/fstab` などをパイプで JSON にすることもできる。

```sh
$ cat /etc/hosts | jc --hosts | jq
[
  {
    "ip": "127.0.0.1",
    "hostname": [
      "localhost"
    ]
  },
  // ... 省略 ...
]
```

xml, yaml, csv, ini, .env もパイプで JSON にできる。

```sh
$ curl -sSL https://github.com/cli/cli/releases.atom | jc --xml | jq -r '.feed.entry[] | .link["@href"]'
https://github.com/cli/cli/releases/tag/v2.5.2
https://github.com/cli/cli/releases/tag/v2.5.2-pre0
https://github.com/cli/cli/releases/tag/v2.5.1
https://github.com/cli/cli/releases/tag/v2.5.0
https://github.com/cli/cli/releases/tag/v9.9.9-test
https://github.com/cli/cli/releases/tag/v2.4.0
https://github.com/cli/cli/releases/tag/v2.3.0
https://github.com/cli/cli/releases/tag/v2.2.0
https://github.com/cli/cli/releases/tag/v2.1.0
https://github.com/cli/cli/releases/tag/v2.0.0
```

### pup

<https://github.com/ericchiang/pup>

HTML を CSS セレクターで絞り込める。
絞り込んだあとは HTML を JSON に変換できる。

```sh
$ http example.com | pup 'h1 json{}'
[
  {
    "tag": "h1",
    "text": "Example Domain"
  }
]
```

### fx

<https://github.com/antonmedv/fx>

JS と互換性のあるクエリで jq のようにクエリを絞り込める。
また [lodash](https://lodash.com/docs/) で定義されている関数がデフォルトで使えるし、 `~/.fxrc` に設定を書くことで関数を自分で定義することもできる。
さらにクエリ無しでコマンドを呼び出すと vim ライクなキーバインドでインタラクティブに JSON を閲覧できる。

かなり多機能だが、クエリを書くという点では他の多くの人が使っている `jq` に合わせるほうが無難なシーンも多いし、インタラクティブに見る機能については `jless` の方が優れていると思う。
無人島に一つしか JSON を操るコマンドを持っていけないなら `fx` を持っていくが、そういう状況になったことはないのであまり使っていない。

### jql

<https://github.com/yamafaktory/jql>

`jq` ライクな Rust 製のコマンド。
`jq` ほどサポートしている操作は多くない。

代わりに `jq` を使っている。

### jiq

<https://github.com/fiatjaf/jiq>

`jq` と互換性のあるクエリを書きながら JSON をインタラクティブに絞れる。

絞り込んだ後にエンターを押すとデフォルトでは絞り込んだ結果の JSON が標準出力に出る(パイプに流せる)。
`-q` オプションを付けた状態で、絞り込んだ後にエンターを押すとクエリ自体が出力される。

1回だけ手動でデータを取得したいだけなら後述の `jless` を使うほうが恐らく楽。
シェルスクリプトなどで何かしら自動化する余地があるなら `jq` のクエリが必要になるので `jiq -q` が便利。

代わりに `curry jq` を使っている。

### jid

<https://github.com/simeji/jid>

`jiq` と似ている。クエリを書きながら絞り込んで行くタイプ。
しかし別に `jq` と互換性があるわけではない。
例えば `[{"id": 1}, {"id": 2}]` を `.[]` というクエリで処理した結果は `jiq` では `null` になる。

代わりに `curry jq` を使っている。

## cookbook

### yaml2json, yml2json

```sh
jc --yaml
```

### xml2json

```sh
jc --xml
```

### html2json

```sh
pup 'body json{}'
```

## その他

- <https://github.com/burningtree/awesome-json#readme>
