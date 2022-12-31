---
title: CLI tools
---

## common

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

- [guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#basics)
- [ripgrep は {grep, ag, git grep, ucg, pt, sift} より速い (翻訳)](https://inzkyk.xyz/misc/ripgrep/#%e5%bc%be%e4%b8%b8%e3%83%84%e3%82%a2%e3%83%bc)

### [hgrep](https://github.com/rhysd/hgrep)

better grep.

- [えっちな grep をつくった](https://rhysd.hatenablog.com/entry/2021/11/23/211530)

### [fd](https://github.com/sharkdp/fd)

better find.

### [difft](https://github.com/Wilfred/difftastic)

better diff.

### [delta](https://github.com/dandavison/delta)

better diff for git.

### [rip](https://github.com/nivekuil/rip)

ファイル削除ではなく、「ファイルをゴミ箱に移動する」的な機能をターミナルで行うツール。

`rip foo` で `./foo` をゴミ箱に移動、 `rip -s` でゴミ箱の中身一覧を表示、 `rip -u` でゴミ箱から元のディレクトリにファイルを復元。

README では `rm` のエイリアスに設定することは推奨していないが、自分の場合はエイリアスにしている。

### [sd](https://github.com/chmln/sd)

better sed.
