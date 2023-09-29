---
title: Burp Suite Certified Practitioner 受験レポート
---

## この記事の目的

最近、 Burp Suite Certified Practitioner (BSCP) というセキュリティ系の試験を受けて合格しました。  
この試験に関する情報があまり出回っていないようなので、どのような試験なのかを伝えられればと思います。

また、セキュリティを自身の専門分野として持っている人がこの試験を受けていることが多いようですが、自分の場合はセキュリティの専門家というわけではなくて普通の Web エンジニアとして働いています。

そういった目線での受験レポートは新鮮で価値のあるものになるのではないかと思います。

## Burp Suite Certified Practitioner (BSCP) とは

Burp Suite という主に Web アプリケーションの脆弱性診断に使われるアプリケーションが存在します。  
これは業界的にはほぼデファクトスタンダードと言っていい存在ではないかと思います。

この Burp Suite を開発している PortSwigger 社が提供している試験が BSCP です。  
この試験では Web セキュリティに関する知識が以下のような方式で問われます。

- 受験場所はどこでもいい (自宅でいい)
- 試験時間は 4 時間
- 攻略するべきアプリケーションが 2 つある
- 2 つのアプリケーションそれぞれについて、以下 3 つのタスクを全て完了させる
  - Stage 1: 他人のアカウントを乗っ取る
  - Stage 2: 乗っ取ったアカウントを踏み台にして、管理者権限のアカウントを乗っ取る
  - Stage 3: 管理者権限のアカウントを使って、サーバのファイルシステムからフラグを読み取り、試験システムに提出する

脆弱性の発生原理、見つけ方、悪用のされ方、(誤った)典型的な防御のバイパス手法などを理解して、時間内にそれを示す必要があります。

受験をする条件として PortSwigger が提供する [Web Security Academy](https://portswigger.net/web-security/learning-path) 上でいくつかのタスクを完了させる必要があります。  
Web Security Academy では各脆弱性についての解説と、その脆弱性を利用した攻撃を実践できる Lab と呼ばれる環境が提供されます。
完了させるべきタスクは以下の 4 つです。

- Step 1: 指定された Lab を 23 個解く
  - これは PortSwigger の Web Security Academy で扱われている各脆弱性について、それぞれ 1 個の Lab が含まれています
- Step 2: 指定された Lab を 8 個解く
  - これは恐らく PortSwigger 社的に最低限知っておいてほしいと考えられるようなものがピックアップされているのだと思います
- Step 3: Mystery Lab を 5 回解く
  - 通常の Lab に関してはその Lab のタイトルでどんな脆弱性があるのか分かるようになっていますが、 Mystery Lab ではタイトルが隠されています
  - 特にヒントが無い状況から脆弱性を探す形式となっており、現実の脆弱性診断、模擬試験、本番の試験に近い形式となっています
- Step 4: 模擬試験を受ける
  - 本番同様に Stage 1~3 のタスクを完了させる必要があります
  - ただし攻略するアプリケーションは 2 つではなく 1 つで、試験時間も 4 時間ではなく 2 時間となっています

試験費用は 99 USD です。  
ただしそれに加えて、無償の Burp Suite Community Edition ではなく有償の Burp Suite Professional Edition を 449 USD で購入する必要があります。

なので 99 + 449 で約 550 USD ほどかかることになります。  
Burp Suite の Professional Edition に興味が無い方にとっては、もしかしたら割高かもしれません。  
自分の場合は技術力向上のための投資としては許容できる金額だと判断しました。

## 勉強内容

とにかく基本は PortSwigger の [Web Security Academy](https://portswigger.net/web-security/learning-path) でした。  
[Learning Path のページ](https://portswigger.net/web-security/learning-path)から適当なトピックを 1 つ選んで、解説を読んで、Lab を解くという作業を全てのトピックに対して行いました。

Lab に関しては Apprentice, Practioner, Expert の 3 つの難易度がありますが、 Practioner 以下の難易度に設定されている Lab は全て解きました。  
受験に必要な 4 つのタスクのうち Step 1 と Step 2 ではいくつかの Lab を解くことが要求されていますが、これだけをやって試験に合格する Web エンジニアの割合は多くないと思います。  
(脆弱性診断の経験がある方などは違うと思います)

Practioner までの Lab は 200 以上あって全て完了するのはそれなりに時間がかかります。  
しかしほとんどの Lab で何かしら新しい学びがあるようになっているので、個人的には楽しみながら解くことができました。

例えば SQL インジェクションは古典的な脆弱性であるため当然知ってはいたのですが、 sleep ベースの SQL インジェクションが実際にどのようなペイロードで悪用されうるのかということに関しては、ぼんやりとした認識がある程度でした。  
こういったぼんやりとした知識全般が Web Security Academy でより明確になったと感じています。

苦手意識がある脆弱性の攻略に関しては Web Security Academy 以外のリソースも活用しました。  
具体的には主に Hack The Box Academy を活用しました。  
Hack The Box Academy も Web Security Academy と同様に、脆弱性の解説とそれを実験できる環境がセットで与えられるような学習リソースです。

解説に関してはどちらか片方を読めば事足りると思いますが、追加の Lab を求めている場合には Hack The Box Academy を活用するのも有効だと思います。  
ただし、PortSwigger の Web Security Academy は無償であるのに対し、 Hack The Box は有償です。  
金額に関してはトピックごとに異なる価格での従量課金制となっており、 1 トピックあたり最大 50 USD くらいの金額です。

PortSwigger の Web Security Academy に関しては本当によくできた資料だとは思うのですが、 Burp Suite 以外のツールについての案内は薄いので、その点が Hack The Box Academy で補えたのが良かったです。

その他 [HackTricks](https://book.hacktricks.xyz/welcome/readme) や [Payloads All The Things](https://swisskyrepo.github.io/PayloadsAllTheThings/) といった資料もよく参考にしていました。

一つの脆弱性について、それを探す時間も悪用に成功させる時間も含めて 40 分程度です。これは十分に長いとは言い難いです。  
なのでチートシートを用意しておくことも有効です。  
自分の場合は他の方が公開している体裁の良いチートシートを見つけたので本番の試験では主にそれを利用しましたが、一応は自分自身でチートシート作成をしました。  
チートシートを書こうとするとちゃんと理解できていない事柄に関しては手が止まってしまうので知識の穴が見つかりますし、知識の整理にも役立つので、本番で使わなかったとしてもチートシートを書くという行為自体は有益だと思います。

## 受験した感想

(前提としてネタバレ防止的な意味で試験の具体的な内容について書けないことはご了承ください)

自分のような立場としては簡単すぎず難しすぎず丁度よい難易度だったなーと感じました。

- 試験開始
- 27 分経過 App 1 Stage 1 クリア
- 90 分経過 App 1 Stage 2 クリア
- 108 分経過 App 1 Stage 3 クリア
- 180 分経過 App 2 Stage 1 クリア
- 204 分経過 App 2 Stage 2 クリア
- 214 分経過 App 2 Stage 3 クリア
- 26 分ほど時間を残して試験終了

こんな感じで時間ギリギリな感じでした。

App 1 Stage 3 を完了して App 2 Stage 1 に移るときは、時間制限があるという緊張の中でまた 1 から脆弱性を探すのかと思ってやや脱力してしまい、さっきと同じ能力をまた発揮できるだろうかという不安も感じました。  
しかしここまでのペースはそんなに悪くない (単純に問題数で試験時間を割った値で考えると、12 分ほど余裕がある) し、もし不合格ならまた 1 からやり直す必要があると思うと、そんな考えはすぐに拭えました。

App 2 Stage 1 では脆弱性を見つけるのにも上手く悪用したペイロードを作るのにも時間がかかってしまい、ここで時間内に終わらないのではないかという不安は強まりました。  
しかし無事にここは突破できて、Stage 2 と Stage 3 は特に酷いハマり方はせず、なんとか時間内に全てのタスクを完了することができました。

土曜日の正午頃に受験して、火曜日の夕方に合格を通知するメールが来ました。

攻略した脆弱性について試験を終えてから振り返ってみると、基本的には素朴なものが多かったかなという印象です。  
Web Security Academy に書いてある全ての内容を理解/記憶していれば、ほぼ間違いなく合格すると思います。  
Web セキュリティを専門としていて経験豊富な人がこの試験を受けたとしたら、4 時間の試験時間を使い切ることはなくて 1~2 時間前後で解き終わるのではないかと思います。

とはいえ、この試験は全てのタスクをクリアしないと合格にならないので、 BSCP に挑む前の自分を含めて平均的な Web エンジニアがいきなり受験して合格するのは難しいと思います。  
この試験に合格したということは、そういった知識を新たに身につけられたということなので受験してよかったかなと思っています。

## まとめ

- Web Security Academy がオススメです！
- Web Security Academy がオススメです！！
- Web Security Academy がオススメです！！！

普通の Web エンジニアがセキュリティについての知見を深めるためのロードマップの一例として、この記事が参考になれば幸いです。
分かりやすい目標を立てて新しい知識を獲得していく過程が楽しかったので、今後しばらくは Offensive Security Web Expert (OSWE) に向けて精進していこうと思います。

## 参考資料など

- 自分以外の人が書いたレビュー
  - [Burp Suite Certified Practitioner になりました - ANDPAD Tech Blog](https://tech.andpad.co.jp/entry/2022/09/15/100000)
  - [Study & Exam Guide for the Burp Suite Certified Practitioner (BSCP) \| by Jacob Larsen \| Jul, 2023 \| Medium](https://jacobcyber.medium.com/study-exam-guide-for-the-burp-suite-certified-practitioner-bscp-a64abdebfd38)
  - [My Review: Burp Suite Certified Practitioner! \| by Astik Rawat \| Medium](https://astikrawat.medium.com/my-review-burp-suite-certified-practitioner-8269bb8e382f)
  - [Burp Suite Certified Practitioner (BSCP) Exam Review: Passed \| by Gorigorisensei \| Medium](https://gorigorisenseiblog.medium.com/burp-suite-certified-practitioner-exam-review-passed-b4a0a431b305)
  - [Burp Suite Certified Practitioner (BSCP) Review and Tips – KentoSec](https://kentosec.com/2023/04/09/burp-suite-certified-practitioner-bscp-review-and-tips/)
  - [BSCP Review \| Marmeus's Website](https://marmeus.com/post/review-bscp)
  - [Burp Suite Certified Practitioner Exam Review \| Micah Van Deusen's Blog](https://micahvandeusen.com/burp-suite-certified-practitioner-exam-review/)
- チートシート
  - [BSCP 攻略チートシート](https://gist.github.com/wonda-tea-coffee/53b130206fef6a3021a21fd7d7ec36db)
  - [botesjuan/Burp-Suite-Certified-Practitioner-Exam-Study: Burp Suite Certified Practitioner Exam Study](https://github.com/botesjuan/Burp-Suite-Certified-Practitioner-Exam-Study)
  - [Obfuscating attacks using encodings \| Web Security Academy](https://portswigger.net/web-security/essential-skills/obfuscating-attacks-using-encodings)
  - [Google \| site:https://portswigger.net/web-security/ XSS](https://www.google.com/search?q=site%3Ahttps%3A%2F%2Fportswigger.net%2Fweb-security%2F+XSS)
- 学習リソース
  - [All learning materials - detailed \| Web Security Academy](https://portswigger.net/web-security/all-materials/detailed)
  - [Hack The Box Academy](https://academy.hackthebox.com/)
  - [HackTricks](https://book.hacktricks.xyz/welcome/readme)
  - [Payloads All The Things](https://swisskyrepo.github.io/PayloadsAllTheThings/)
