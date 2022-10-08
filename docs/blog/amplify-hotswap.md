---
title: Amplify で function の hotswap を実現する方法について
date: 2021-12-08 22:00:02
---

この記事は「[AWS Amplify Advent Calendar 2021](https://qiita.com/advent-calendar/2021/amplify)」の9日目の記事です。

CloudFormation 経由でのデプロイは一貫性を保ちやすい一方で時間がかかります。

最近は Lambda をデプロイするツールに CloudFormation を経由せずに高速にデプロイをする機能が実装されることが増えてきたように思えます。
自分が把握しているだけで以下のツールがそれを実装しています。

- [Serverless Stack](https://dev.classmethod.jp/articles/serverless-stack/)
- [CDK](https://aws.amazon.com/jp/about-aws/whats-new/2021/10/aws-cdk-releases-hotswap-rollback-control/)
- [SAM](https://aws.amazon.com/jp/blogs/news/aws-sam-accelerate/)

Amplify の function にも同様の機能があると嬉しいですが、残念ながらまだ実装されていません。
そこでホットスワップ機能をプラグインという形で実装したので、今回はそのプラグインについて紹介します。

## amplify-function-hotswap-plugin

`amplify-function-hotswap-plugin` という名前のプラグインを実装して公開しました。
https://github.com/lambdasawa/amplify-function-hotswap-plugin にてソースコードとデモを確認することができます。

### 設計

Amplify はプラグインの作り方を https://docs.amplify.aws/cli/plugins/authoring/ にて公開しており、この仕組みを利用することによって `amplify` コマンドのサブコマンドを `amplify-cli` のリポジトリに手を加えることをなく作成することができます。
`amplify-function-hotswap-plugin` はこの仕組みを利用して `amplify amplify-function-hotswap-plugin watch` というコマンドでホットスワップを開始できるようになっています。

このコマンドが実行されると `amplify-function-hotswap-plugin` は `amplify/backend/function` 以下のファイル監視を開始し、ファイル変更を検出するとその Lambda に対して `lambda:UpdateFunctionCode` のオペレーションを呼び出して Lambda のコードを更新します。
これは素朴な操作なので短時間で完了します。
参考程度に自分が開発に参加している Amplify のプロジェクトでは `amplify push` だと 2 分程度かかるところが、このホットスワップの仕組みでは 10 秒程度で完了します。

また、 Amplify では `amplify/backend/function` 以下に Lambda 関数だけではなく Lambda レイヤーのコードが入ることもあります。
`amplify-function-hotswap-plugin` ではそのケースにも対応しています。
つまり、 Lambda レイヤーのコードが更新された場合は新たな Lambda レイヤーのコードがアップロードされ、そのレイヤーに依存している関数も同時に更新されます。
この依存関係は `amplify/amplify-meta.json` を読み取ることで把握しています。

AWS の API コールを行う際のクレデンシャルは `amplify/.config` 以下のファイルを参照して通常の `amplify` コマンドと同様のものを使用しています。

### 実装

いくつかボイラープレート的なファイルはありますが、本体の実装は https://github.com/lambdasawa/amplify-function-hotswap-plugin/blob/main/commands/watch.js の1ファイルのみです。

[`node-watch`](https://www.npmjs.com/package/node-watch) でファイル監視を行い、  [`amplify-cli-core`](https://www.npmjs.com/package/amplify-cli-core) で各種設定ファイルをパースし、 `aws-sdk` で実際に更新を行います。
とても素朴な実装です。

### 今後

素朴な仕組みではありますが、自分が開発に参加しているプロジェクトのメンバーの皆さんはこのプラグインを利用してくれており、上手く機能しているようです。

本来はこのような仕組みがプラグインではなく `amplify-cli` 自体に含まれているのが望ましいと考えており、  [Issue](https://github.com/aws-amplify/amplify-cli/issues/8642) と [プルリク](https://github.com/aws-amplify/amplify-cli/pull/8686) を作ってみました。
しかし残念ながら上手く進めることができておらず、やりとりが止まってしまっています。
何か上手く進めるためのアドバイスなどがあれば教えていただけると幸いです。
