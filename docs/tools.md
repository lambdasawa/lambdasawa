# λ沢を支える技術

## summary

- [fish](https://github.com/lambdasawa/lambdasawa/blob/main/docs/tools.md#fish)
  - カスタマイズしなくても高度な補完が使えて便利
- [zoxide](https://github.com/lambdasawa/lambdasawa/blob/main/docs/tools.md#zoxide)
  - `cd` を使うならぜひ
- [Raycast](https://github.com/lambdasawa/lambdasawa/blob/main/docs/tools.md#raycast)
  - Mac を使ってるならぜひ
- [VSCode Code Ace Jumper](https://github.com/lambdasawa/lambdasawa/blob/main/docs/tools.md#code-ace-jumper)
  - VSCode を使ってるならぜひ
- [VSCode expand-region](https://github.com/lambdasawa/lambdasawa/blob/main/docs/tools.md#expand-region)
  - VSCode を使ってるならぜひ

## ToC

<!-- Markdown All in One: Update Table of Contents -->

- [λ沢を支える技術](#λ沢を支える技術)
  - [summary](#summary)
  - [ToC](#toc)
  - [CLI](#cli)
    - [fish](#fish)
    - [asdf](#asdf)
    - [direnv](#direnv)
    - [zoxide](#zoxide)
    - [starship](#starship)
    - [sk](#sk)
    - [watchexec](#watchexec)
  - [better ls, cat, grep find and more](#better-ls-cat-grep-find-and-more)
    - [exa](#exa)
    - [bat](#bat)
    - [rg](#rg)
    - [hgrep](#hgrep)
    - [fd](#fd)
    - [delta](#delta)
    - [rip](#rip)
    - [sd](#sd)
  - [ターミナル](#ターミナル)
    - [tmux](#tmux)
    - [tmuxinator](#tmuxinator)
    - [tmux-jump](#tmux-jump)
  - [Git](#git)
    - [tig](#tig)
    - [git-extras](#git-extras)
    - [ghq](#ghq)
    - [lefthook](#lefthook)
  - [GitHub](#github)
    - [gh](#gh)
    - [actionlint](#actionlint)
  - [HTTP](#http)
    - [httpie](#httpie)
    - [CyberChef](#cyberchef)
    - [ngrok](#ngrok)
    - [webhook.site](#webhooksite)
    - [mitmproxy](#mitmproxy)
    - [httpbin](#httpbin)
    - [websocat](#websocat)
    - [graphqurl](#graphqurl)
  - [JSON](#json)
    - [jq](#jq)
    - [jc](#jc)
    - [gron](#gron)
    - [quicktype](#quicktype)
  - [JWT](#jwt)
    - [jwt-cli](#jwt-cli)
  - [AWS](#aws)
    - [aws-vault](#aws-vault)
    - [utern](#utern)
    - [amplify-function-hotswap-plugin](#amplify-function-hotswap-plugin)
    - [lambda-versions.com](#lambda-versionscom)
    - [convert-datetime-to-cloudwatch-cron-expression-git-master.lambdasawa.vercel.app](#convert-datetime-to-cloudwatch-cron-expression-git-masterlambdasawavercelapp)
  - [AWS IaC](#aws-iac)
    - [Terraform](#terraform)
    - [AWS CDK](#aws-cdk)
    - [Serverless Framework](#serverless-framework)
  - [DynamoDB](#dynamodb)
    - [dynein](#dynein)
  - [Elasticsearch and OpenSearch](#elasticsearch-and-opensearch)
    - [cerebro](#cerebro)
    - [awscurl](#awscurl)
  - [シェルスクリプト](#シェルスクリプト)
    - [shellcheck](#shellcheck)
    - [shfmt](#shfmt)
  - [Docker](#docker)
    - [localstack](#localstack)
    - [minio](#minio)
    - [MailHog](#mailhog)
    - [wait](#wait)
  - [Kubernetes](#kubernetes)
    - [lens](#lens)
  - [Android](#android)
    - [scrcpy](#scrcpy)
  - [負荷テスト](#負荷テスト)
    - [k6](#k6)
    - [gatling](#gatling)
  - [ネットワーク](#ネットワーク)
    - [checkip.amazonaws.com](#checkipamazonawscom)
    - [db-ip.com](#db-ipcom)
  - [その他の CLI ツール](#その他の-cli-ツール)
    - [ouch](#ouch)
    - [hostctl](#hostctl)
    - [trans](#trans)
    - [glow](#glow)
    - [dotfiles の bin](#dotfiles-の-bin)
      - [tmuxopen](#tmuxopen)
      - [wait-change](#wait-change)
      - [ghs](#ghs)
      - [wait-gha](#wait-gha)
      - [selectnpm](#selectnpm)
      - [cloudwatch-logs-query](#cloudwatch-logs-query)
  - [VSCode Extension](#vscode-extension)
    - [GitHub Copilot](#github-copilot)
    - [GistPad](#gistpad)
    - [Code Ace Jumper](#code-ace-jumper)
    - [expand-region](#expand-region)
    - [change-case](#change-case)
    - [Unique Lines](#unique-lines)
    - [Code Spell Checker](#code-spell-checker)
    - [Better Comments](#better-comments)
    - [Todo Tree](#todo-tree)
    - [Bracket Lens](#bracket-lens)
    - [indent-rainbow](#indent-rainbow)
    - [Rainbow CSV](#rainbow-csv)
    - [Error Gutters](#error-gutters)
    - [ShellCheck](#shellcheck-1)
    - [Monokai Pro](#monokai-pro)
  - [デスクトップアプリケーション](#デスクトップアプリケーション)
    - [Raycast](#raycast)
    - [IntelliJ IDEA Ultimate](#intellij-idea-ultimate)
    - [VSCode](#vscode)
    - [1Password](#1password)
    - [Krisp](#krisp)
    - [CloudMounter](#cloudmounter)
  - [Firefox Addon](#firefox-addon)
    - [Tree Style Tab](#tree-style-tab)
    - [Tridactyl](#tridactyl)
    - [1Password X](#1password-x)
    - [Multi Account Containers](#multi-account-containers)
    - [uBlacklist](#ublacklist)
    - [Refined GitHub](#refined-github)
    - [Gitako](#gitako)
    - [AWS Extend Switch Roles](#aws-extend-switch-roles)
    - [Notion Boost](#notion-boost)
    - [Pushbullet](#pushbullet)
    - [Wappalyzer](#wappalyzer)
  - [情報収集](#情報収集)
  - [その他](#その他)

## CLI

### [fish](https://fishshell.com/)

複雑な設定無しで高度な補完を使えるので fish shell を使っている。
bash をカスタマイズして使っていたこともあるが、結局は fish に帰ってくることになった。

`cd` したあとは自動で `ls` が叩かれるように `cd` コマンドを再定義している。
また、 `cd` の引数が無い場合はカレントディレクトリ以下を fuzzy filter で一覧表示 & あいまい検索 & 選択できるようにしている。

```fish
function cd
    set d "$argv"
    if [ -z "$argv" ]
        # filter は sk, fzf, peco などのエイリアス。
        set d (fd --type d | filter) 
    end

    builtin cd "$d"
    
    # list は exa などの better ls 的なツールのエイリアス。未インストールなら素の ls にフォールバック。
    list || ls
end
```

fish はコマンドの実行前後を簡単にフックできる。

コマンド実行直前に適当なディレクトリにタイムスタンプを書き込み、コマンド完了直後にそのタイムスタンプと現在時刻を比較して、コマンドの実行時間を計算している。
コマンドの実行時間がしきい値を超えている場合にはデスクトップ通知と音声での通知を出している。

これによって長いビルドやデプロイが走り出したとき、別のウィンドウで作業を始めてもコマンドが終了した瞬間に素早く気付ける。
コマンドが終わったかどうか定期的に確認したりする必要は無くなるし、コマンドがとっくに終わってるのに別のウィンドウでの暇つぶしが無駄に長引くことがなくなる。

(似たようなことは [`starship` の `duration` モジュール](https://starship.rs/config/#command-duration)でもできる)

```fish
function fish-prehook-long-command-notifier --on-event fish_preexec
    mkdir -p ~/tmp/fish/process/start_at/
    date +%s >~/tmp/fish/process/start_at/$fish_pid
end

function fish-posthook-long-command-notifier --on-event fish_postexec
    set -l s $status
    set message Success
    if [ $s -ne 0 ]
        set message Failure
    end

    set -l duration_sec (math (date +%s) - (cat ~/tmp/fish/process/start_at/$fish_pid))
    set -l threshold_sec 3
    if [ $duration_sec -ge $threshold_sec ]
        set -l a (echo $argv)
        echo "$message: $a"
        
        # noti は osascript や notify-send でのデスクトップ通知を処理する。
        which noti 2>&1 >/dev/null && noti "$message: $a"
        
        # voice コマンドは say コマンドのエイリアス。スピーカーやイヤホンから Success (または Failure) と発音される。
        which voice 2>&1 >/dev/null && voice $message &
    end
end
```

指をいたわるために [alias](https://github.com/lambdasawa/lambdasawa/blob/main/.config/fish/alias.fish) を活用していている。

### [asdf](https://asdf-vm.com/)

コマンドラインツールのバージョンを管理してくれるツール。 `anyenv` 的なもの。`nodenv`, `rbenv` と同等のことを言語をまたいで行ってくれる。

各ツールはプラグインという概念で管理される。

```sh
# asdf で nodejs を管理できるように設定
asdf plugin add nodejs

# 18.4.0 をインストールして ~/.tool-versions にバージョンを記載
asdf global install nodejs 18.4.0 

# 18.4.0 をインストールして ./.tool-versions にバージョンを記載
asdf local install nodejs 18.4.0

# .tool-versions が含まれるリポジトリをクローンしてそのディレクトリで asdf install を実行すると、
# そのバージョンがインストールされる
asdf install
```

プラグインによるが、 `~/.default-hoge-packages` というファイルにパッケージ名を書いておくと、 `asdf install` (or `asdf global install` or `asdf local install`) でそのパッケージをインストールできるようになる。

```sh
echo eslint >> ~/.default-npm-packages
echo prettier >> ~/.default-npm-packages

# nodejs の最新版がインストールされると同時に、 eslint, prettier がインストールされる
asdf global install nodejs latest 
```

### [direnv](https://direnv.net/)

特定ディレクトリに移動した時に、任意のコマンドを実行するツール。
`.env` ファイルを読み込んでシェルに環境変数を設定する目的で使うことが多い。

シェルに環境変数を設定しなくてもフレームワークやライブラリの機能を使って `.env` を読めるケースもあるが、ちょっとしたオペレーションの際にそのフレームワークの外で環境変数が欲しくなるようなケースもあるので、フレームワーク依存の機能で `.env` を読み込むことをあまり好まない。
言語非依存の `direnv` を使うのが好み。

### [zoxide](https://github.com/ajeetdsouza/zoxide)

過去に移動したディレクトリのパスの一部を引数で渡すとそのディレクトリに移動できるツール。

例えば `/Users/lambdasawa/src/github.com/lambdasawa/zenn` に `cd` したことがあるなら、カレントディレクトリがどこだったとしても `z zenn` だけで `/Users/lambdasawa/src/github.com/lambdasawa/zenn` に移動できる。

### [starship](https://starship.rs/ja-jp/)

シェルのプロンプトをカスタマイズするフレームワーク。 TOML で簡単に管理できる。

現在のシェルで使われている言語のバージョン、 git のステータス、直前のコマンドに実行にかかった時間と exit code、 AWS/GCP のプロファイル名などを表示している。

### [sk](https://github.com/lotabout/skim)

`peco` や `fzf` のような fuzzy finder などと呼ばれるツール。 Rust 製。

### [watchexec](https://github.com/watchexec/watchexec)

カレントディレクトリ以下のファイルの変更を監視し、ファイルの変更をトリガーにして任意のコマンドを実行するツール。

`watchexec -e go -- go test ./...` などとすると、 `.go` の変更があったときに `go test ./...` を実行することができる。

## better ls, cat, grep find and more

### [exa](https://github.com/ogham/exa)

better ls.

### [bat](https://github.com/sharkdp/bat/blob/master/doc/README-ja.md)

better cat/less.

### [rg](https://github.com/BurntSushi/ripgrep)

better grep.

- [ripgrep は {grep, ag, git grep, ucg, pt, sift} より速い (翻訳)](https://inzkyk.xyz/misc/ripgrep/#%e5%bc%be%e4%b8%b8%e3%83%84%e3%82%a2%e3%83%bc)

### [hgrep](https://github.com/rhysd/hgrep)

better grep.

- [えっちな grep をつくった](https://rhysd.hatenablog.com/entry/2021/11/23/211530)

### [fd](https://github.com/sharkdp/fd)

better find.

### [delta](https://github.com/dandavison/delta)

better diff.

### [rip](https://github.com/nivekuil/rip)

ファイル削除ではなく、「ファイルをゴミ箱に移動する」的な機能をターミナルで行うツール。

`rip foo` で `./foo` をゴミ箱に移動、 `rip -s` でゴミ箱の中身一覧を表示、 `rip -u` でゴミ箱から元のディレクトリにファイルを復元。

README では `rm` のエイリアスに設定することは推奨していないが、自分の場合はエイリアスにしている。

### [sd](https://github.com/chmln/sd)

better sed.

## ターミナル

Mac 標準のターミナルを使っている。 iTerm2, Alacritty などサードパーティのターミナルエミュレータは使っていない。VSCode 内のターミナルもほとんど使っていない。

テーマは [Monokai Pro](https://github.com/Monokai/monokai-pro-sublime-text/issues/45#issuecomment-341005595) を使っている。

### [tmux](https://github.com/tmux/tmux/wiki)

いわゆるターミナルマルチプレクサ。

- 設定をテキストファイルで管理できる
- 全てキーボードで操作できる
- ターミナル内でタブ的な概念を扱ったり、画面分割したりできる
- ターミナルに表示されているテキストをクリップボードにコピーできる
- この辺りの操作を tmux でやることによって、ターミナルエミュレータに以前せず多くの環境で同じような操作感を維持できる

### [tmuxinator](https://github.com/tmuxinator/tmuxinator)

tmux のセッションの設定をテキストファイルで管理できる。

以下、自分の使用方法。

- 1リポジトリ = セッション
- `go run`, `npm start`, `flutter run` などのアプリケーションを動かすペイン + 雑多なタスク用のペイン = 1 ウィンドウ

### [tmux-jump](https://github.com/schasse/tmux-jump)

tmux 内に表示されている任意の箇所に 3~5 キーくらいでカーソルを移動できる。

エラーメッセージを他人にシェアしたりググったりするときにターミナルに表示されている文字列をコピーすることがあるので、主にそのようなシチュエーションで使っている。

## Git

`git-wrapper` というシェルスクリプトを用意してある。

`git-wrapper` は引数が 0 個なら `tig` を起動する。
引数が 1 個 && それが `gh` のサブコマンドになっている場合は `gh` に引数を渡し、それ以外の場合は `git` に引数を渡す。

`git-wrapper`は `g` にエイリアスされてる。

例えば `g` は単に `tig` を起動して、 `g commit` は `git commit` のように振る舞い、 `g pr list` は `git pr list` のように振る舞う。

いくつかサブコマンドを追加している。
`.gitconfig` の [alias](https://github.com/lambdasawa/lambdasawa/blob/main/.config/git/alias) 由来のもの、 [git-extras](https://github.com/tj/git-extras/blob/master/Commands.md) 由来のもの、 `dotfiles` の [bin](https://github.com/lambdasawa/lambdasawa/tree/main/bin) 由来のものがある。

- `g current-branch`
  - 現在のブランチ名を stdout に書く
- `g root`
  - カレントディレクトリが属するディレクトリのリポジトリルートの絶対パスを stdout に書く
  - `git rev-parse --show-toplevel` と同等
- `g brv`
  - ブランチ一覧をオシャレに表示する
- `g lv`
  - コミットログをオシャレに表示する
- `g day`
  - 昨日のコミットログを表示する
- `g week`
  - 1週間分のコミットログを表示する
- `g rpv`
  - カレントディレクトリのリポジトリをブラウザで開く
- `g prv`
  - 現在のブランチに紐付いたプルリクをブラウザで開く
- `g review`
  - 自分がレビュワーに設定されているプルリク一覧をブラウザでまとめて開く
- `g hgrep`
  - `hgrep` でリポジトリ内を検索
- `g log-filter`
  - `git log` を `fzf` に流して選択したコミットの SHA を stdout に書く
- `g reflog-filter`
  - `git reflog` を `fzf` に流して選択したコミットの SHA を stdout に書く
- `g sed foo bar`
  - リポジトリ内のファイルに含まれる `foo` を全て `bar` に置換する
- `g abort`
  - `merge`, `rebase`, `cherry-pick` 時に conflict した状態から元に戻る
- `g clear-soft`
  - `git status` が空になるような状態にする
- `g clear`
  - `git clone` 直後のような状態にする

### [tig](https://jonas.github.io/tig/)

TUI の git クライアント。
設定をテキストファイルで管理できる点、全ての操作がキーボードで行える点が良い。

### [git-extras](https://github.com/tj/git-extras/blob/master/Commands.md)

`git` を用いた便利なサブコマンド集。

### [ghq](https://github.com/x-motemen/ghq)

リポジトリ管理をするツール。
リポジトリの URL とローカルのディレクトリを紐付けて管理できる。

自分の場合はホームディレクトリ以下を FHS (Filesystem Hierarchy Standard) っぽく管理してる。

```sh
$ cat ~/.gitconfig | grep -A 3 ghq
[ghq]
root = ~/src
user = lambdasawa

$ ghq list
github.com/lambdasawa/www.lambdasawa.me
github.com/lambdasawa/zenn
github.com/raycast/script-commands
```

これでリポジトリをどこにクローンするか悩まなくて済む。

### [lefthook](https://github.com/evilmartians/lefthook)

`git hooks` を管理するツール

- 特定の言語に依存していないのが良い
- `lefthook run hoge` でタスクランナーとしても使用できるのが良い

## GitHub

### [gh](https://github.com/cli/cli)

GitHub の CLI。

- リポジトリの作成に使っている
  - `gh pr create --public --push --source .`
- カレントディレクトリのリポジトリをブラウザで開きたいときに使っている
  - `gh repo view -w`
- プルリクの作成に使っている
  - `git push -u origin $(git rev-parse --abbrev-ref HEAD) && gh pr create --assignee @me --draft --fill`
- 現在チェックアウトしているブランチのプルリクをブラウザで開きたいときに使っている
  - `gh pr view -w`
- 自分がレビューする必要のプルリク一覧をまとめてブラウザで開くワンライナー
  - `gh pr list -S "review-requested:@me" | awk '{print $1}' | xargs -n 1 gh pr view -w`
- GitHub Codespaces の環境をリセットするワンライナー
  - `gh codespace delete --all -f && gh codespace create --repo lambdasawa/(basename $PWD) && gh codespace code`

### [actionlint](https://github.com/rhysd/actionlint)

GitHub Actions のワークフローファイルの linter.

## HTTP

### [httpie](https://httpie.io/docs/cli/usage)

人間に優しい `curl`。

```sh
# こんな感じで JSON を POST できる
$ http -v "https://httpbin.org/anything" "x-my-header: xxxx" foo[bar]=fizz

# 同等の処理を curl でやるとこんな感じ
$ curl -v "https://httpbin.org/anything" -X POST -H "x-my-header: xxxx" --data '{"foo": {"bar": "fizz"}}'
```

レスポンスは自動的にインデントとシンタックスハイライトがされる。

### [CyberChef](https://gchq.github.io/CyberChef/)

雑多な変換処理を行えるウェブサイト。

- base64
- URL エンコード/デコード
- gunzip
- zlib deflate
- JWT デコード
- などなど

使用例:

- [Unix timestamp to RFC3339(JST)](https://gchq.github.io/CyberChef/#recipe=From_UNIX_Timestamp('Milliseconds%20(ms)')Translate_DateTime_Format('Standard%20date%20and%20time','ddd%20DD%20MMM%20YYYY%20HH:mm:ss','UTC','YYYY-MM-DDTHH:mm:ss','Asia/Tokyo')&input=MTY1NjI4NzU2NDE5Ng)
- [JWT decode](https://gchq.github.io/CyberChef/#recipe=JWT_Decode()&input=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnpkV0lpT2lJeE1qTTBOVFkzT0Rrd0lpd2libUZ0WlNJNklrcHZhRzRnUkc5bElpd2lhV0YwSWpveE5URTJNak01TURJeWZRLlNmbEt4d1JKU01lS0tGMlFUNGZ3cE1lSmYzNlBPazZ5SlZfYWRRc3N3NWM)

### [ngrok](https://ngrok.com/)

localhost のポートに一時的なドメインを割り当ててインターネットに公開できるコマンド。

ローカル環境をシュッと HTTPS 環境にしたり、 Webhook の開発をする際に便利。

他にも同様のツールはいくつかあるが、課金すればドメインを一時的でランダムなものではなく固定できる点とアクセスログが見れる点が気に入っている。

参考: [awesome-tunneling](https://github.com/anderspitman/awesome-tunneling)

### [webhook.site](https://webhook.site/)

ランダムな URL を発行してくれるサイト。
そのサイトに POST するとリクエストのヘッダー、ボディなどが保存され、このサイト上からそれを確認できる。
Webhook 開発の際に便利。

また、 ランダムなメアドも発行してくれる。
ログイン機能の開発時や捨てアカウントを作るときに便利。

これも課金するとランダムな部分を固定にできる。

### [mitmproxy](https://mitmproxy.org/)

HTTP プロキシツール。

REST な API と通信するスマホアプリの開発時に、スマホからアクセスする API サーバのアドレスを mitmproxy に設定して、 mitmproxy が API サーバを参照するように設定すると、 req/res が mitmproxy のコンソールから確認できて便利。

スマホアプリではなく Web アプリであれば Developer Tool を見れば通信内容を把握できるが、スマホアプリでは mitmproxy を見ると便利。

### [httpbin](https://httpbin.org/)

色んな種類の HTTP エンドポイントが公開されているサイト。

HTTP クライアントの検証に便利。

### [websocat](https://github.com/vi/websocat)

WebSocket を扱う CLI クライアント。

### [graphqurl](https://github.com/hasura/graphqurl)

GraphQL を扱う CLI クライアント。

## JSON

### [jq](https://stedolan.github.io/jq/)

JSON のフォーマット、クエリをするコマンド。

### [jc](https://github.com/kellyjonbrazil/jc)

色んなテキストフォーマットを JSON に変換するコマンド。

ちょっとしたテキストファイルの処理をしたいときに JSON になってると jq で処理できて便利。

使用例:

```sh
# docker compose のサービス一覧を確認
$ cat docker-compose.yml | jc --yaml | jq -r '.[0].services | to_entries[] | .key'
mysql
redis
app

# GitHub の RSS を XML としてパース最新バージョンを確認
$ curl -sSL https://github.com/docker/docker/releases.atom | jc --xml | jq -r '.feed.entry[0].title'
v20.10.17

# ifconfig の結果を JSON に変換して jq でフィルタリングしてローカル IP アドレスを確認
$ jc ifconfig | jq -r '.[] | .ipv4_addr | select(. != null) | select(. != "127.0.0.1")'
xxx.xxx.xxx.xxx
```

### [gron](https://github.com/tomnomnom/gron)

JSON を grep,diff などのコマンドで処理しやすいフラットなフォーマットに変換してくれるコマンド。

```sh
$ curl -sSL https://httpbin.org/json | gron
json = {};
json.slideshow = {};
json.slideshow.author = "Yours Truly";
json.slideshow.date = "date of publication";
json.slideshow.slides = [];
json.slideshow.slides[0] = {};
json.slideshow.slides[0].title = "Wake up to WonderWidgets!";
json.slideshow.slides[0].type = "all";
json.slideshow.slides[1] = {};
json.slideshow.slides[1].items = [];
json.slideshow.slides[1].items[0] = "Why <em>WonderWidgets</em> are great";
json.slideshow.slides[1].items[1] = "Who <em>buys</em> WonderWidgets";
json.slideshow.slides[1].title = "Overview";
json.slideshow.slides[1].type = "all";
json.slideshow.title = "Sample Slide Show";
```

### [quicktype](https://app.quicktype.io/)

JSON から Go の構造体、 TypeScript の interface などを生成するコマンド。

```sh
$ curl -sSL https://httpbin.org/json | npx quicktype --lang go --just-types
type TopLevel struct {
        Slideshow Slideshow `json:"slideshow"`
}

type Slideshow struct {
        Author string  `json:"author"`
        Date   string  `json:"date"`
        Slides []Slide `json:"slides"`
        Title  string  `json:"title"`
}

type Slide struct {
        Title string   `json:"title"`
        Type  string   `json:"type"`
        Items []string `json:"items,omitempty"`
}
```

似たようなツールとして [transform.tools](https://transform.tools) がある。

## JWT

### [jwt-cli](https://github.com/mike-engel/jwt-cli)

JWT をデコードする CLI。

```sh
$ jwt decode -j eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
{
  "header": {
    "typ": "JWT",
    "alg": "HS256"
  },
  "payload": {
    "iat": 1516239022,
    "name": "John Doe",
    "sub": "1234567890"
  }
}
```

## AWS

### [aws-vault](https://github.com/99designs/aws-vault)

- [aws-vault を使って AWS のアクセスキーを暗号化して扱おう](https://blog.microcms.io/aws-vault-introduction/)

### [utern](https://github.com/knqyf263/utern)

CloudWatch Logs を `tail -f` のようにリアルタイムにターミナルに流すコマンド。

### [amplify-function-hotswap-plugin](https://github.com/lambdasawa/amplify-function-hotswap-plugin)

CDK の `--watch` のように Amplify の `functions` を シームレスに更新するコマンド。

### [lambda-versions.com](http://lambda-versions.com/)

Lambda ランタイムのパッチバージョンを確認できるサイト。

`asdf` とかでパッチバージョンを決めるときに使っている。

### [convert-datetime-to-cloudwatch-cron-expression-git-master.lambdasawa.vercel.app](https://convert-datetime-to-cloudwatch-cron-expression-git-master.lambdasawa.vercel.app/)

CloudWatch Events (EventBridge) で使える `cron` 式の生成をするサイト。

## AWS IaC

- CloudFormation
  - [リソースのリファレンス](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)
  - [組み込み関数のリファレンス](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)

### [Terraform](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started)

- [リファレンス](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

### [AWS CDK](https://docs.aws.amazon.com/cdk/v2/guide/hello_world.html)

- [ガイド](https://docs.aws.amazon.com/cdk/v2/guide/home.html)
- [リファレンス](https://docs.aws.amazon.com/cdk/api/v1/docs/aws-construct-library.html)
- [examples](https://github.com/aws-samples/aws-cdk-examples/tree/master/typescript)

### [Serverless Framework](https://www.serverless.com/framework/docs/getting-started)

- [リファレンス](https://www.serverless.com/framework/docs/providers/aws/guide/serverless.yml)
- [examples](https://www.serverless.com/examples/)

## DynamoDB

### [dynein](https://github.com/awslabs/dynein#commands-overview)

DynamoDB へのアクセスを考えた時、 awscli は網羅的であるが `expression-attribute-values` の指定が面倒だったりする。

`dynein` を使うとその辺りをシンプルに書ける。

まだ成熟してない(例えばページング処理が実装されてない)が、 基本的なユースケースでは awscli より便利。
リポジトリにコミットしてシェアするようなスクリプトでは awscli を使ったほうが良いと思うが、一時的な調査の作業などには便利。

## Elasticsearch and OpenSearch

### [cerebro](https://github.com/lmenezes/cerebro)

ブラウザベースの Elasticsearch の管理ツール。

node, index, shard の状態をグラフィカルに確認したり、シャードを移動したりできる。

```sh
docker run -d -p 9000:9000 lmenezes/cerebro
export OPENSEARCH_ENDPOINT=$(aws opensearch describe-domain --domain-name $(aws opensearch list-domain-names | jq -r '.DomainNames[] | .DomainName' | fzf) | jq -r .DomainStatus.Endpoint)
open $(node -e 'console.log("http://localhost:9000/#!/overview?host=" + encodeURIComponent(`https://${process.env.OPENSEARCH_ENDPOINT}`))')
```

### [awscurl](https://github.com/okigan/awscurl)

```sh
awscurl --service es --profile lambdasawa --region ap-northeast-1 "https://opensearch.example.com/_cat"
```

- [リファレンス](https://opensearch.org/docs/latest/opensearch/rest-api/index/)

## シェルスクリプト

### [shellcheck](https://github.com/koalaman/shellcheck)

シェルスクリプトの linter.

### [shfmt](https://github.com/mvdan/sh#shfmt)

シェルスクリプトのフォーマッタ。

## Docker

### [localstack](https://github.com/localstack/localstack)

AWS の各環境をモックする Docker イメージ。

### [minio](https://github.com/minio/minio)

S3 互換のオブジェクトストレージを提供する Docker イメージ。Web UI もついてて、まあまあ使いやすい。

### [MailHog](https://github.com/mailhog/MailHog)

メール関連の機能開発時にローカルで使えるメールサーバ。

このコンテナに対して SMTP or HTTP でメールを送って、 Web UI で送られたメールを確認できる。

### [wait](https://github.com/ufoscout/docker-compose-wait)

特定のポートが開くまで wait するツール。

コンテナで DB を立ち上げてすぐにマイグレーションスクリプトを実行すると、コンテナは起動してるが中で初期化処理が実行中でまだポートが空いてないからエラー…みたいなことがよくある。
その時は単に `migrate-hoge` コマンドを使うのではなく、 `wait` コマンドと組み合わせて `wait && migrate-hoge` とかやると良い。

## Kubernetes

### [lens](https://k8slens.dev/)

GUI で Cluster, Node, Pod の状態確認/操作できるツール。

シュッと kubectl exec できたりして便利。

## Android

### [scrcpy](https://github.com/Genymobile/scrcpy)

実機 Android の画面を PC に転送して、マウスとキーボードで操作できるようにするツール。

モバイルアプリ開発で実機を触るときにスマホを持ったりおいたりするのが面倒なので、全部 PC 内で完結すると便利。

## 負荷テスト

### [k6](https://k6.io/docs/using-k6/http-requests/)

JS でシナリオを書ける負荷テストツール。

- [API reference](https://k6.io/docs/javascript-api/)
- [TypeScript](https://github.com/grafana/k6-template-typescript)

### [gatling](https://github.com/gatling/gatling)

Scala でシナリオを書ける負荷テストツール。

## ネットワーク

### [checkip.amazonaws.com](https://checkip.amazonaws.com/)

グローバル IP を確認できるサイト。

### [db-ip.com](https://db-ip.com/)

```sh
open https://db-ip.com/$(dig github.com | jc --dig | jq -r '.[0].answer[0].data')
```

## その他の CLI ツール

### [ouch](https://github.com/ouch-org/ouch)

`zip`, `tar.gz`, `tar.bz2`, `tar.xz` などのファイルを展開するツール。

`tar` のオプションで迷ったりせず、 全部 `ouch decompress $FILE` で良い。

### [hostctl](https://github.com/guumaster/hostctl)

`/etc/hosts` に要素を追加したり、まとめて削除したりできるコマンド。

ビジネスロジックにドメインが含まれるようなサービスの開発時は `/etc/hosts` を頻繁にいじることがあるので、そういう作業をするときはこれを使うと便利。

### [trans](https://github.com/soimort/translate-shell)

CLI で使える Google 翻訳。

```sh
$ alias entoja="trans -s en -t ja"
$ alias jatoen="trans -s ja -t en"

$ entoja
hello
hello
/həˈlō/

こんにちは
(Kon'nichiwa)

hello の定義
[ English -> 日本語 ]

名詞
    今日は
        hello, good day

hello
    こんにちは
```

### [glow](https://github.com/charmbracelet/glow)

CLI の markdown レンダラー。

```sh
$ glow README.md

   I'm λ沢 (pronounced as lambda sour)

  • Backend engineer
  • Infrastructure engineer (Cloud)
  • Gopher
  • Japanese
  • λ沢.me https://www.lambdasawa.me
  • λ沢を支える技術 https://github.com/lambdasawa/lambdasawa/blob/main/docs/tools.md
```

### [dotfiles の bin](https://github.com/lambdasawa/lambdasawa/tree/main/bin)

dotfiles で色々便利スクリプトを用意してる。いくつかよく使うもの or 多少複雑なものを選択してここに記載する。

#### [tmuxopen](https://github.com/lambdasawa/lambdasawa/blob/3896919910276f559622995d5fb79a224736149d/bin/tmuxopen)

ghq で管理されているリポジトリを fuzzy filter で選んで tmux で開くコマンド。

#### [wait-change](https://github.com/lambdasawa/lambdasawa/blob/3896919910276f559622995d5fb79a224736149d//bin/wait-change)

引数で受け取ったコマンドを実行し続けて、その出力結果に変化があったときに終了するコマンド。

例えば CloudFront を作ってそのステータスを確認するコマンドを `wait-change` に渡すと、CloudFront の作成が完了したときにコマンドが終了する。
そして `fish` の postexec でデスクトップ通知と音声通知が発火することによってそれを素早く簡単に認知できる。

#### [ghs](https://github.com/lambdasawa/lambdasawa/blob/3896919910276f559622995d5fb79a224736149d//bin/ghs)

自分の GitHub/Gist を検索するコマンド。

`gists typescript` で自分が書いた TypeScript に関するコードと Gist 一覧がブラウザで開かれる。

#### [wait-gha](https://github.com/lambdasawa/lambdasawa/blob/3896919910276f559622995d5fb79a224736149d//bin/wait-gha)

GitHub Actions の終了を待つコマンド。

これも `wait-change` と同様にジョブが完了するとデスクトップ通知と音声通知を受け取ることができる。

#### [selectnpm](https://github.com/lambdasawa/lambdasawa/blob/3896919910276f559622995d5fb79a224736149d//bin/selectnpm)

カレントディレクトリのリポジトリにある npm モジュールを一覧で出して fuzzy filter で選択するコマンド。

npm のモノリポを扱っているときに `cd $(selectnpm)` を実行すると任意のサブパッケージにシュッと移動できて便利。

#### [cloudwatch-logs-query](https://github.com/lambdasawa/lambdasawa/blob/3896919910276f559622995d5fb79a224736149d/3/bin/cloudwatch-logs-query)

CloudWatch Logs Insights にクエリを発行するコマンド。

aws-cli でやるとクエリ発行、クエリ状態確認、クエリ結果取得のコマンドを3つ叩く必要があって面倒だが、これを使うとシュッとクエリを投げられて便利。

```sh
$ cloudwatch-logs-query "2022-06-01T00:00:00+09:00" "2022-06-30T23:59:59+09:00" /aws/lambda/my-api '
  fields httpMethod, path, queryStringParameters
  | sort @timestamp desc
  | limit 20
  | filter queryStringParameters.foo = "bar"
'
[
  {
    "httpMethod": "GET",
    "path": "/api/foo",
    "queryStringParameters": { "foo": "bar" }
  },
  {
    "httpMethod": "GET",
    "path": "/api/bar",
    "queryStringParameters": { "foo": "bar", "fizz": "buzz" }
  }
]
```

## VSCode Extension

### [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)

TODO

### [GistPad](https://marketplace.visualstudio.com/items?itemName=vsls-contrib.gistfs)

VSCode のサイドバーに自分の Gist 一覧が表示され、そのファイルを選択するとローカルのファイルを編集するように Gist を編集できる。

`Cmd + s` で Gist 上のファイルが更新される。

### [Code Ace Jumper](https://marketplace.visualstudio.com/items?itemName=lucax88x.codeacejumper)

エディタに表示されている任意の識別子に 3~5 キーのみでジャンプできるようになる。

カーソルキーを連打しなくて済むので指に優しい。

### [expand-region](https://marketplace.visualstudio.com/items?itemName=letrieu.expand-region)

ショートカットキーを連打すると現在のカーソル位置を中心に選択範囲をが広がっていく。

イメージとしては1回目で `"foo"` が選択され、2回目で `myFunction("foo")` が選択され、 3回目で `func main() { myFunction("foo", "bar") }` が選択される感じ。

カーソルキーを連打するより少ないキー入力で目的の範囲を選択できるので指に優しい。

### [change-case](https://marketplace.visualstudio.com/items?itemName=wmaurer.change-case)

`PascalCase`, `snake_case`, `kebab-case`, `camelCase` を相互に変換できる。

### [Unique Lines](https://marketplace.visualstudio.com/items?itemName=bibhasdn.unique-lines)

`uniq` コマンドと同等の処理を VSCode 上で行える。

### [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)

スペルミスしている部分が VSCode 上で青い波線で強調される。

固有名詞が誤検知されることもあるが、ホワイトリストを指定できる。

### [Better Comments](https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments)

`TODO:`, `FIXME:` などのコメントがハイライトされる。

### [Todo Tree](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree)

`TODO:` コメントが書かれた場所が VSCode のサイドバーで確認できる。

### [Bracket Lens](https://marketplace.visualstudio.com/items?itemName=wraith13.bracket-lens)

閉じカッコのところに開きカッコ周辺のコードがどんな感じだったかを表示してくれる。

### [indent-rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)

インデントの深さごとにインデントに色がつく。

### [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)

CSV の列ごとに色がつく。

### [Error Gutters](https://marketplace.visualstudio.com/items?itemName=IgorSbitnev.error-gutters)

各種 Linter などで問題が検出されたときに VSCode の行番号を表示するところにアイコンが表示されて、どの行に問題があるか分かりやすくなる。

### [ShellCheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)

ShellCheck というシェルスクリプトの Linter を VSCode 上で実行できる。問題のある箇所は赤い波線でハイライトされる。

### [Monokai Pro](https://marketplace.visualstudio.com/items?itemName=monokai.theme-monokai-pro-vscode)

TODO

## デスクトップアプリケーション

### [Raycast](https://www.raycast.com/)

ランチャー兼、ウィンドウマネージャ兼、クリップボードマネージャ兼、電卓。

[Alfred](https://www.alfredapp.com/), [Rectangle](https://rectangleapp.com/), [Clippy](https://clipy-app.com/) 的なやつがオールインワンで入っている。

使用例:

- `Command + Option + i` で `IntelliJ IDEA` を起動して最前面にフォーカス
- `Command + Option + c` で `VSCode` を起動して最前面にフォーカス
- `Command + Option + a` でフォーカス中のウィンドウを右のウィンドウに移動
- `Command + Option + m` でフォーカス中のウィンドウを最大化
- `7 days to sec` → `604,800 s`
- `0.1 USD per hour * 30 days to JPY` → `¥9,735`

### [IntelliJ IDEA Ultimate](https://www.jetbrains.com/ja-jp/idea/)

JavaScript, TypeScript 以外のプログラミング言語でコードを書くときはだいたい IntelliJ を使用している。

MySQL, PostgreSQL などの RDB の GUI クライアントとしても使用している。

### [VSCode](https://code.visualstudio.com)

JavaScript, TypeScript を書くとき、 IDE の設定をするほどでもない小規模なプログラムを書くときは VSCode を使用している。

### [1Password](https://1password.com/jp/)

パスワードマネージャとして使用している他、SSH のエージェントとしても使用している。

- <https://developer.1password.com/docs/ssh/get-started>

### [Krisp](https://krisp.ai/)

ノイズキャンセリングをするソフトウェア。
自分のマイクに対してもスピーカーに対してもノイズを抑えられる。

バーチャル背景の設定も可能。

### [CloudMounter](https://cloudmounter.net/jp/)

GoogleDrive, Dropbox を NFS としてマウントできるソフトウェア。

## Firefox Addon

### [Tree Style Tab](https://addons.mozilla.org/ja/firefox/addon/tree-style-tab/)

タブ一覧をサイドバーに表示できる。

タブの親子関係を管理して、特定のノード以下のタブをまとめて fold/unfold したり close したりできる。

### [Tridactyl](https://addons.mozilla.org/ja/firefox/addon/tridactyl-vim)

ブラウザを Vim っぽく操作できる。

コマンドを JS で定義することも可能。

設定をテキストファイルで管理できる。

### [1Password X](https://addons.mozilla.org/ja/firefox/addon/1password-x-password-manager)

### [Multi Account Containers](https://addons.mozilla.org/ja/firefox/addon/multi-account-containers/)

Firefox のタブをコンテナという枠で管理できる。

コンテナが異なると Cookie などが分けて管理される。

コンテナ A では開発環境の AWS コンソールを表示、 コンテナ B ではステージング環境の AWS コンソールを表示、などとすると都度スイッチロールする手間が省けて便利。

### [uBlacklist](https://addons.mozilla.org/ja/firefox/addon/ublacklist)

- [技術系の情報をググるときにStack Overflowの機械翻訳サイトを回避する技術](https://blog.munieru.jp/entry/2020/07/31/080000)

### [Refined GitHub](https://addons.mozilla.org/ja/firefox/addon/refined-github-/)

GitHub の UI がちょっと改善される。

### [Gitako](https://addons.mozilla.org/ja/firefox/addon/gitako-github-file-tree)

GitHub 上でファイル構造がサイドバーにツリー形式で表示される。

最近 GitHub のアップデートによってプルリクのページではアドオン無しでもツリーが表示されるようになったが、 Gitako があるとリポジトリのトップページでもツリーが表示される。

### [AWS Extend Switch Roles](https://addons.mozilla.org/ja/firefox/addon/aws-extend-switch-roles3)

AWS のスイッチロールの設定をテキストで管理できる。

### [Notion Boost](https://addons.mozilla.org/ja/firefox/addon/notion-boost/)

Notion の UI がちょっと改善される。

### [Pushbullet](https://www.pushbullet.com)

このアドオンを Firefox に入れると Android で受け取ったプッシュ通知が Firefox に送られてくる。

### [Wappalyzer](https://addons.**mozilla**.org/ja/firefox/addon/wappalyzer)

アクセスしているページでどんな技術 (ex: WordPress, AWS, Cloudflare...) が使われているか解析してくれる。

## 情報収集

いくつかの Twitter アカウントを TweetDeck で眺めている。

- [@it_hatebu](https://twitter.com/it_hatebu)
- [@zenn_dev](https://twitter.com/zenn_dev)
- [@publickey](https://twitter.com/publickey)
- [@ProductHunt](https://twitter.com/ProductHunt)
- [@stackshareio](https://twitter.com/stackshareio)
- [@jser_info](https://twitter.com/jser_info)
- [@AWSBlogs](https://twitter.com/AWSBlogs)
- [@awscloud_jp](https://twitter.com/awscloud_jp)
- [@awscloud](https://twitter.com/awscloud)
- [@github](https://twitter.com/github)
- [@GHchangelog](https://twitter.com/GHchangelog)
- [@code](https://twitter.com/code)
- [@googledevjp](https://twitter.com/googledevjp)
- [@googlecloud_jp](https://twitter.com/googlecloud_jp)
- [@GoogleCloudTech](https://twitter.com/GoogleCloudTech)
- [@1Password](https://twitter.com/1Password)
- [@raycastapp](https://twitter.com/raycastapp)
- [@firefox](https://twitter.com/firefox)

GitHub で興味の範囲が近そうなユーザと自分が利用しているツールを作っている Organization をフォローして、彼らがスターを付けたリポジトリや公開したリポジトリを眺めている。

必要に応じて awesome-hogehoge を眺める([参考](https://github.com/sindresorhus/awesome))。

## その他

- [JetBrains Mono](https://www.jetbrains.com/ja-jp/lp/mono/)
- [YubiKey 5 NFC](https://www.yubico.com/yubikey/?lang=ja)
- [Tile](https://thetileapp.jp/)
- [Corne Cherry](https://bit-trade-one.co.jp/selfmadekb/adskbcc/)
- [SlimBlade Trackball](https://www.kensington.com/p/products/electronic-control-solutions/trackball-products/slimblade-trackball/)
- [Nature Remo 3](https://nature.global/nature-remo/nature-remo-3/)
- [アサヒ飲料 モンスター カオス 355ml×24本 \[エナジードリンク\]](https://www.amazon.co.jp/dp/B00DV94XZA)
- [【3年0組】郡道美玲の教室](https://www.youtube.com/channel/UCeShTCVgZyq2lsBW9QwIJcw?sub_confirmation=1)
- [ねくろちゃん -Yamaguro Nekuro- /あおぎり高校](https://www.youtube.com/channel/UCs-lYkwb-NYKE9_ssTRDK3Q?sub_confirmation=1)
