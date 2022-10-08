---
title: Lambda のパッチバージョンが見れるサイトを機械可読にした
date: 2021-08-26 15:00:00
---

http://lambda-versions.com/

https://www.lambdasawa.me/blogs/aws-lambda-runtime-patch-versions で投稿したものを更新しました。

今までは HTML しか返していなかったのですが、 JSON 用のエンドポイント ([http://lambda-versions.com/versions.json](http://lambda-versions.com/versions.json)) を追加しました。
これによって機械的な処理 (ex: curl & jq) が行いやすくなりました。

ついでに今まで S3 の static website hosting で払い出されれたドメインを使っていましたが、分かりやすいドメイン (http://lambda-versions.com/
) を割り当ててあげました。

## 実装: Lambda

もともとシンプルに S3 で静的なファイルをホスティングしているだけのサイトでした。
コストを掛けずに運用したいという理由でそれは今後も変えたくなかったため、API Gateway や Web アプリケーションフレームワークは導入していないです。
代わりにこのバケットへの PutObject をトリガーにして起動する Lambda を作成し、その Lambda 内で既存のバージョン情報をかき集めて JSON ファイルを作成してそれをさらに PutObject する仕組みを作りました。

ここで一つ事故が起こりました。
PutObject を実行する Lambda と PutObject をトリガーにして起動する Lambda が存在しているため、Lambda が無限に起動し続ける可能性がある状態になっており、実際に無限ループしていました。
自分の場合は1時間くらいで気がつけたので問題ないですが、いわゆるクラウド破産的な高額請求が発生しうるケースでした。参考: [10日間 で AWS Lambda 関数を 28億回 実行した話](https://blog.mmmcorp.co.jp/blog/2019/12/25/lambda-cloud-bankruptcy/)
(とはいえ、請求金額に対するアラームは設定済みなので実際の損失は数千円で止められたと思います)

もちろん現在は修正済みです。
今回は一次対応としては手動で Lambda のトリガーを削除しました。
その後に根本対応として、PutObject しようとするファイルに差分があるか事前にチェックし、差分があった場合のみ PutObject をするように Lambda のコードを修正しました。
差分が無い場合は PutObject されないのでそこでループが止まります。

今回は採用しなかったやり方ですが、 S3 バケットを分割することによっても対処できたと思います。

## 実装: ドメイン

シンプルに static website hosting の設定を Route 53 でエイリアスレコードとして割り当てました。
10日ほど前にカヤックさんが [CloudFrontのS3 Originにはhostヘッダーを転送してはいけない](https://techblog.kayac.com/do-not-use-cloudfront-s3-origin-with-managed-all-viewer) という記事を公開していましたが、ちょうどこれと同じ問題に直面しました。
タイムリーですね。

## 最後に

面倒な問題が2つ発生しましたが、日頃からある程度キャッチアップをしておいたおかげで類似の問題をすぐ思い出すことができて、素早く対処できました。
Feedly を眺めている時間が無駄になっていないようで良かったです。
