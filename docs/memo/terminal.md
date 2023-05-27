---
title: ターミナル
---

Mac 標準のターミナルを使っている。
[iTerm2](https://iterm2.com/), [Alacritty](https://alacritty.org/), [WezTerm](https://wezfurlong.org/wezterm/) などサードパーティのターミナルエミュレータは使っていない。
VSCode 内のターミナルもほとんど使っていない。

テーマは [Monokai Pro](https://github.com/Monokai/monokai-pro-sublime-text/issues/45#issuecomment-341005595) を使っている。

## [tmux](https://github.com/tmux/tmux/wiki)

いわゆるターミナルマルチプレクサ。

- 設定をテキストファイルで管理できる
- 全てキーボードで操作できる
- ターミナル内でタブ的な概念を扱ったり、画面分割したりできる
- ターミナルに表示されているテキストをクリップボードにコピーできる
- この辺りの操作を tmux でやることによって、ターミナルエミュレータに以前せず多くの環境で同じような操作感を維持できる

## [tmuxinator](https://github.com/tmuxinator/tmuxinator)

tmux のセッションの設定をテキストファイルで管理できる。

以下、自分の使用方法。

- 1リポジトリ = セッション
- `go run`, `npm start`, `flutter run` などのアプリケーションを動かすペイン + 雑多なタスク用のペイン = 1 ウィンドウ

## [tmux-jump](https://github.com/schasse/tmux-jump)

tmux 内に表示されている任意の箇所に 3~5 キーくらいでカーソルを移動できる。

エラーメッセージを他人にシェアしたりググったりするときにターミナルに表示されている文字列をコピーすることがあるので、主にそのようなシチュエーションで使っている。
