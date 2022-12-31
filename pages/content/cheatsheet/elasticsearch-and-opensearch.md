---
title: Elasticsearch and OpenSearch
---

- [guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [awesome](https://github.com/dzharii/awesome-elasticsearch)
- [cheatsheet](http://elasticsearch-cheatsheet.jolicode.com/)
- [DevelopersIO Elasticsearch入門](https://dev.classmethod.jp/referencecat/enter-elasticsearch/)
- [Compact and aligned text (CAT) APIs](https://www.elastic.co/guide/en/elasticsearch/reference/current/cat.html)
- [Cluster API](https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster.html)
- [Index API](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices.html)
- [Document API](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs.html)
- [Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)

## glossary

- ドキュメント
  - MySQL などの RDB で言うところのレコード
- インデックス
  - ドキュメントの集合
  - インデックスにはエイリアスを付けることができる
    - 旧インデックスと新インデックスを2つ用意してエイリアスでそれを切り替えることによってダウンタイム無しでインデックス再構築をできる
    - エイリアスには複数のインデックスを紐付けることができる
- ノード
  - 物理的なサーバのこと
  - master, data, ingest, coordinating などのロールがある
    - [この4つが紹介されることが多いが、これ以外のロールも存在する](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#node-roles)
  - 1つのノードが複数のロールを兼任することができる
- master node
  - ノードの一種
  - 他のノードの制御などを行う
- data node
  - ノードの一種
  - データの読み書きを行う
- ingest node
  - ノードの一種
  - data node が処理をする前にドキュメントの変換を行う
  - 例えば文字列で送られてきたアクセスログを JSON に変換するとか
- coordinating node
  - ノードの一種
  - リクエストの負荷分散、複数シャードにまたがった検索のマージなどを行う
  - 他のロールと違って明示的に指定するものではなく、全てのノードが暗黙的に coordinating node でもある
- クラスタ
  - ノードの集合
- シャード
  - インデックスを分割した単位
  - RDB で言うところのパーティションに近い概念
  - 1シャードあたり 30GB 程度で推奨されることが多い
- プライマリシャード
  - シャードの一種
  - 書き込み、読み込みがされる
  - `number_of_shards` の数だけ作成される
- レプリカシャード (レプリカと略されて呼ばれることが多い)
  - シャードの一種
  - リードオンリー
  - `number_of_shards * number_of_replicas` の数だけ作成される
  - RDB で言うところのレプリカ、スレーブと近い概念
  - プライマリシャードが死ぬとレプリカシャードのどれかがプライマリシャードになる
  - プライマリシャードとレプリカシャードは同じノードに配置されない
- Lucene インデックス
  - シャードの実態は Lucene のインデックス
  - Elasticsearch は検索のアプリケーション、 Lucene は検索のライブラリ
- Lucene セグメント
  - Lucene インデックスの実態は複数の Lucene セグメント
  - Lucene セグメントはイミュータブル
    - 更新時は既存のセグメントが論理削除され、新しいセグメントが新たに作られる
    - 頻繁にカウンターを更新したりするようなワークロードは Elasticsearch では遅くなりやすい
    - 論理削除されたセグメントは時々物理削除される
    - [API を呼び出して強制的にマージ処理を走らせることも可能](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-forcemerge.html)
- スプリットブレイン
  - 一つのクラスターが複数のクラスターに分断されること
  - データの整合性が取れなくなる
  - 例えば2つのノードで構成されたクラスターがネットワーク障害で分断されると発生する
  - マスターが落ちたときにどのノードを新しいマスターにするか投票が行われるが、マスターになるために必要な最低票数を `総ノード数/2+1` に設定するとこれを防げる
    - この最低票数は `discovery.zen.minimum_master_nodes` という設定で管理される
    - 2台のノードから構成するクラスタで `minimum_master_nodes` を1に設定してしまうと 1:1 に分断されたときに両方マスターノードになってしまう
      - 2台では冗長性が十分でないことから、3台以上のノードを使ってクラスタを構築することが推奨される
    - 3台のノードから構成するクラスタで `minimum_master_nodes` を1に設定してしまうと 1:2 に分断されたときに両方マスターノードになってしまう
    - 3台のノードから構成するクラスタでは `minimum_master_nodes` を2に設定するのは OK
      - 1:2 に分断されても 1 の方はマスターにならない
    - 4台のノードから構成するクラスタでは `minimum_master_nodes` を2に設定してしまうと 2:2 に分断されたときに両方マスターノードになってしまう
      - 3台以上でも偶数台だとスプリットブレイン問題が起きてしまうため良くない
    - 4台のノードから構成するクラスタは `minimum_master_nodes` を3に設定すると…
      - スプリットブレイン問題は起きない
      - しかし2台のノードに障害でアクセスできなくなったとすると、そのクラスターはマスターノードを選出できない
      - つまりこの構成で失えるノード数は1台までといえる
      - これは3台構成のときも同じ
      - この構成は3台構成より高い可用性を持っているわけではなく、余計にコストがかかっているだけなので推奨されない
    - 5台のノードから構成するクラスタでは `minimum_master_nodes` を3に設定するのは OK
      - 1:4 に分断されても 1 の方はマスターにならない
      - 2:3 に分断されても 2 の方はマスターにならない
      - 1:1:3 に分断されても 1 の方はマスターにならない
      - 1:2:2 に分断されるとどれもマスターにならない

- [Elasticsearch from the Bottom Up, Part 1](https://www.elastic.co/jp/blog/found-elasticsearch-from-the-bottom-up)
- [Node](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html)
- [Index](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-modules.html)
- [Merge](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-modules-merge.html)

## [cerebro](https://github.com/lmenezes/cerebro)

ブラウザベースの Elasticsearch の管理ツール。

node, index, shard の状態をグラフィカルに確認したり、シャードを移動したりできる。

```sh
docker run -d -p 9000:9000 lmenezes/cerebro
export OPENSEARCH_ENDPOINT=$(aws opensearch describe-domain --domain-name $(aws opensearch list-domain-names | jq -r '.DomainNames[] | .DomainName' | filter) | jq -r .DomainStatus.Endpoint)
sleep 60
open "http://localhost:9000/#!/overview?host=$(jq -nr '"https://\(env.OPENSEARCH_ENDPOINT)" | @uri')"
```
