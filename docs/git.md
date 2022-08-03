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
