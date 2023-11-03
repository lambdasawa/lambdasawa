---
title: デスクトップ環境のこだわり
---

## PC

- 一緒に仕事をする人が Mac を使っているので Mac を使っている
- Linux Desktop を使っていた頃は XMonad を愛用していた
- Mac を使っている今では Raycast を使っている
- 積極的に Windows を使いたいと思う理由は特にない

## マウス/トラックボール

- Kensington Slim Blade を使い続けている
- 特に不満はない
- クリック音がデカいのはちょっと気になる
## キーボード

- REALFORCE → HHKB → Kinesis Advantage 2 → ErgoDox → Viterbi → Iris → Corne という流れで色々変えてきた
- ここ3年くらいは最近は小さめのキーボードにハマっている
- Kinesis Advantage 360 の無線版を2つ入手したらそっちに移行するかもしれない

### HHKB に対する不満

- 打鍵感に関する不満はない
- ショートカットキーを使い倒す前提だと、小指の負荷が高くて親指の負荷が低い
- 親指のほうが太くて丈夫なのに

### Kinesis Advantage 2 に対する不満

- 小指と親指の負荷のバランスは良い感じ
- Kinesis Advantage 2 はファンクションキーの打鍵感が気に入らない
- 一部のキーが遠くてホームポジションが崩れる
- 英数/かなに相当するキーが無くて IME の変更がトグルでやるしかない
	- トグルにしたくない
	- 現在の IME が英語だろうが日本語だろうが、英数キーを押したら英語になってほしい

### 自作キーボード

- 自分が知る限り、上記の不満を全て解決するキーボードは一般的には売られていないので、自作キーボードの類を使うしかない
- 大事なことは以下
	- 親指が活用されること
	- ホームポジションが崩れにくいこと
		- これはレイヤー機能を使うことで解決できる
		- レイヤー機能があること ≒ プログラマブルであること
	- 分割されていること
		- よく肩こりに効くみたいなことを言われているが、元々肩こりなどの悩みがなかったのでそんなに実感はない
		- 分割されていなキーボードをたまに使うと「体がｷﾞｭｯとしてるな〜」とは感じるので、相対的には楽にはなっているはず
- 少なくとも 3x5 + 親指キー3つは必要
	- 今は 3x6 + 親指キー3つのキーボード (Corne) を使っている
		- 余ったキーは F13~F20 を割り当てている
		- 詳しくは後述
	- キーが多すぎるとホームポジションが崩れる問題に繋がる
		- 大は小を兼ねるため、大きくても致命的な問題にはならない
		- 余ったキーは無視すれば良いだけ
		- しかし無駄なキースイッチとキーキャップを買う必要があるので経済的ではない

## ディスプレイ

- どうせヒトが注視できるのは1箇所なので1枚でも問題ないと思っている
	- Raycast などのランチャーアプリが適切に設定されていれば…という前提
	- アプリを切り替えるのが億劫だと出来るだけ多くのウィンドウが前面に見えている状態が望ましいとは思っている
	- Raycast などのランチャーアプリが適切に設定されていればアプリの切り替えは億劫でなくなる
- とはいえ、ディスプレイが縦に長いと嬉しいシーンもあるので [ASUS の適当なモニタ](https://www.asus.com/jp/displays-desktops/monitors/eye-care/vg278qr-j/  ) を2枚使って片方は横置き、もう片方は縦置きにしている

## デスク

- ニトリの幅120×奥行75×高さ70cmのダイニングテーブルとされているやつ
- https://www.nitori-net.jp/ec/product/4016350/
## 椅子

- ニトリのゲーミングチェアとされているやつ
- https://www.nitori-net.jp/ec/product/6620873/

### レイヤー

デフォルトレイヤー:

- 普通の QWERTY 配列
- 左右の端に F13~F20 が割り当ててある
	- これが Raycast、IntelliJ IDEA、VSCode、BurpSuite のショートカットキーに割り当てられている
	- ショートカットキーのコンフリクトを気にしなくて済む
	- F14, F15 は OS 側に吸われることがあったので使ってない
- 記号は基本的に他のレイヤーにあるが、句読点はよく使うのでこのレイヤーにある
- 親指に修飾キーとレイヤー切り替えのキーがある

```c
  [0] = LAYOUT_split_3x6_3(
      KC_F13 , KC_Q   , KC_W   , KC_E   , KC_R   , KC_T   ,                      KC_Y   , KC_U   , KC_I   , KC_O   , KC_P   , KC_F18 ,
      KC_F16 , KC_A   , KC_S   , KC_D   , KC_F   , KC_G   ,                      KC_H   , KC_J   , KC_K   , KC_L   , KC_RALT, KC_F19 ,
      KC_F17 , KC_Z   , KC_X   , KC_C   , KC_V   , KC_B   ,                      KC_N   , KC_M   , KC_COMM, KC_DOT , KC_RSFT, KC_F20 ,
                                          MO(1)  , KC_LGUI, KC_LCTL,    KC_RALT, KC_RSFT, MO(2)
  ),
```

記号レイヤー:

記号があるだけ。このレイヤーには面白みがない。

```c
 [1] = LAYOUT_split_3x6_3(
      _______, KC_PLUS, KC_MINS, KC_ASTR, KC_SLSH, KC_PERC,                      KC_AT  , KC_COLN, KC_SCLN, KC_LBRC, KC_RBRC, _______,
      _______, KC_HASH, KC_AMPR, KC_PIPE, KC_EQL , KC_EXLM,                      KC_TILD, KC_QUOT, KC_DQUO, KC_LPRN, KC_RPRN, _______,
      _______, KC_CIRC, KC_DLR , KC_BSLS, KC_UNDS, KC_QUES,                      KC_GRV , KC_LT  , KC_GT  , KC_LCBR, KC_RCBR, _______,
                                          MO(3)  , _______, _______,    _______, _______, MO(3)
 ),
```

なんか色々あるレイヤー:

- 左手
	- 通常は T がある位置にマウスの右クリックが並んでいる
		- これはそんなに使わない
	- 通常は G/B がある位置にマウスホイールを上下に動かすキーが並んでいる
		- コードを読んでいるときに page down, page up キーのように使える
	- ホームポジションにhjkl的な感じで十字キーが並んでいる
	- ホームポジションの下の行には home, page down, page up, end が並んでいる
	- ホームポジションの上の行にはマウスカーソルを動かすキーが並んでいる
		- これはそんなに使わない
		- 前述のマウスホイールを操作するキーを押すと、マウスカーソルの位置によってスクロールされるものが変わるのでそれを制御するときに使うくらい
		- 当たり前だけど例えば VSCode にフォーカスが当たっている状態でマウスホイールを操作したとき、マウスカーソルが Explorer の上にあれば Explorer がスクロールされるし、マウスカーソルがコードの上にあればコードがスクロールされる
- 右手
	- enter, space, tab, backspace, delete, escape, 英数, かなキーがある
		- これらのキーを一発で入力できない (レイヤー切り替えのキーを押す必要がある) のは理想的ではない
		- ホームポジションが崩れないというメリットがあるので良しと質得る
	- HYPR_N は Command+Control+Option+Shift+数字キーの意味
		- これも F13~F20 と同じでアプリケーションにデフォルトで定義されているショートカットキーと被らなくて便利
		- だけどまだ使いこなせてない

```c
  [2] = LAYOUT_split_3x6_3(
      _______, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_BTN2,                      HYPR_1 , HYPR_2 , HYPR_3 , HYPR_4 , HYPR_5 , _______,
      _______, KC_LEFT, KC_DOWN, KC_UP  , KC_RGHT, KC_WH_U,                      KANA   , KC_ENT , KC_SPC , KC_TAB , KC_RALT, _______,
      _______, KC_HOME, KC_PGDN, KC_PGUP, KC_END , KC_WH_D,                      EISU   , KC_BSPC, KC_DEL , KC_ESC , KC_RSFT, _______,
                                          MO(3)  , _______, _______,    _______, _______, MO(3)
  ),
```

ファンクションキーと数字キーがあるレイヤー:

- 左手にファンクションキー
- 右手に数字キーがテンキー的な配列である
- MEH_N は Control+Option+Shift+数字キーの意味
	- これも F13~F20 と同じでアプリケーションにデフォルトで定義されているショートカットキーと被らなくて便利
	- MEH_4~MEH_6 にスクリーンショット撮影系の処理を割り当てるよう Mac の System Preferences をいじってある
	- MEH_1~MEH_3 はまだ未割り当て

```c
  [3] = LAYOUT_split_3x6_3(
      _______, KC_F1  , KC_F2  , KC_F3  , KC_F4  , MEH_1  ,                      KC_DOT , KC_7   , KC_8   , KC_9   , MEH_4  , _______,
      _______, KC_F5  , KC_F6  , KC_F7  , KC_F9  , MEH_2  ,                      KC_COMM, KC_4   , KC_5   , KC_6   , MEH_5  , _______,
      _______, KC_F9  , KC_F10 , KC_F11 , KC_F12 , MEH_3  ,                      KC_0   , KC_1   , KC_2   , KC_3   , MEH_6  , _______,
                                          XXXXXXX, _______, _______,    _______, _______, XXXXXXX
  ),
```


https://github.com/lambdasawa/qmk_firmware/blob/master/keyboards/crkbd/keymaps/lambdasawa/keymap.c

## Raycast

### ショートカットキーでアプリを起動/フォーカスを当てる

![](/blog/static/desktop-environment-raycast-app.png)

- Command+Option+m を押したとき…
	- Firefox が起動していなければ起動する
	- 起動しているならばフォーカスを当てる

### ウィンドウマネジメント系

![](/blog/static/desktop-environment-raycast-window-management.png)

- Next Display/Previous Display のコマンドを発行すると、フォーカスの当たっているウィンドウが他のディスプレイに移動する
	- Command+Option+A, E にバインドされている理由は、 Emacs 系のカーソル操作で Ctrl+A, E が行頭行末に移動することに由来してる
- hoge fuga Quarter 系のコマンドを実行すると、ウィンドウのサイズがディスプレイの4分の1のサイズになって hoge fuga の位置に移動する
	- Command+Option+F17 を押すと Bottom Left に移動するように一番上の行で定義されている
	- なぜ F17 が Bottom Left か？
	- F17 はキーボードの左下にマッピングされているので

```c
  [0] = LAYOUT_split_3x6_3(
      KC_F13 , KC_Q   , KC_W   , KC_E   , KC_R   , KC_T   ,                      KC_Y   , KC_U   , KC_I   , KC_O   , KC_P   , KC_F18 ,
      KC_F16 , KC_A   , KC_S   , KC_D   , KC_F   , KC_G   ,                      KC_H   , KC_J   , KC_K   , KC_L   , KC_RALT, KC_F19 ,
      KC_F17 , KC_Z   , KC_X   , KC_C   , KC_V   , KC_B   ,                      KC_N   , KC_M   , KC_COMM, KC_DOT , KC_RSFT, KC_F20 ,
                                          MO(1)  , KC_LGUI, KC_LCTL,    KC_RALT, KC_RSFT, MO(2)
  ),
```

こんなイメージ。

| action                         | key | -   | key | action                         |
| ------------------------------ | --- | --- | --- | ------------------------------ |
| 画面左上にウィンドウを寄せる   | F13 | -   | F18 | 画面右上にウィンドウを寄せる   |
| 画面左半分にウィンドウを寄せる | F16 | -   | F19 | 画面右半分にウィンドウを寄せる |
| 画面左下にウィンドウを寄せる   | F17 | -   | F20 | 画面右下にウィンドウを寄せる   |

### その他のコマンド

![](/blog/static/desktop-environment-raycast-other.png)

- clipboard history
	- ただのクリップボードマネージャー
- search menu items
	- メニューバーにある各メニューをインクリメンタルに検索できる
	- そんなに頻繁には使わないけど、マウスカーソルをウロウロさせてメニューを探すより文字列で探したほうが早いシーンはたまにある
	- Mac のデスクトップアプリケーションの場合、メニューバーの Help から同じことができるけど、その機能にアクセスするための操作がキーボードだけでできるとちょっと嬉しい
- switch windows
	- Mac では同じアプリケーションが複数のウィンドウを持っているとき、特定のウィンドウにフォーカスを当てるというのが難しい
	- アプリケーションとウィンドウは1対多だが、Command+Tab ではアプリケーション単位の指定しかできない
	- Raycast の switch windows はウィンドウ単位での切り替えができる
- search snippets
	- 開発/テスト対象のアプリケーションにテストデータとしてよく使うデータをスニペットに登録してる
	- これをすぐ出せるようにしている
### raycast/script-commands

- 使ってない
- 面白い仕組みだなとは思っているが…
- ターミナルが好きなので、あえて Raycast からコマンドを実行する必要性がない

## IntelliJ IDEA

- All Products Pack を買っている
	- これによって得た生産性で収入が増えているはずなので実質無料
- 言語に依存しないプラグインに絞って言及すると AceJump と String Manipulation を入れてる
- Theme は Monokai Pro を使っている
	- 多分これが一番可愛いと思います

###  F13~20

- コードを読むときによく使うキーマップが割り当ててある
- 右側にコードの下流を読むためのキーマップがある
- 左側には逆にコードの上流を読むためのキーマップがある

| action                | key | -   | key | action               |
| --------------------- | --- | --- | --- | -------------------- |
| Find Usage            | F13 | -   | F18 | Go to implementation |
| Navigate/Back         | F16 | -   | F19 | Navigate/Forward     |
| Code/Folding/Collapse | F17 | -   | F20 | Code/Folding/Expand  |

### Ctrl + F13~20

- Ctrl+A でカーソルが行頭に行くように、カーソルを操作するキーマップをここに置く

| action            | key | -   | key | action                         |
| ----------------- | --- | --- | --- | ------------------------------ |
| Clone Caret Above | F13 | -   | F18 | Move Caret to Code Block Start |
|                   | F16 | -   | F19 | Start AceJump in Target Mode   |
| Clone Caret Berow | F17 | -   | F20 | Move Caret to Code Block End   |

### Shift + F13~20

- Shift+→ で選択領域が広がるように、選択領域を変更するキーマップをここに置く

| action           | key | -   | key | action           |
| ---------------- | --- | --- | --- | ---------------- |
|                  | F13 | -   | F18 |                  |
| Shrink Selection | F16 | -   | F19 | Extend Selection |
|                  | F17 | -   | F20 |                  |

### Option + F13~20

- タブ分割系のキーマップをここに置く

| action                   | key | -   | key | action               |
| ------------------------ | --- | --- | --- | -------------------- |
| Select Previous Splitter | F13 | -   | F18 | Select Next Splitter |
|                          | F16 | -   | F19 | Split Right          |
| Close All Tabs           | F17 | -   | F20 | Split Down           |

### その他

- Option+m: string manipulation
	- これはプラグイン
	- snake_case から camelCase への変換、BASE64 デコードなど細かい文字列操作が色々できる

## VSCode

- ショートカットキー、エスクテンション、テーマについては前述の IntelliJ IDEA と同じ感じ
- 特に珍しいエクステンションは入れてない

## Firefox

- Tree Style Tab, Multi Account Container, Tridactyl が便利なのでメインブラウザとして愛用している
- 普段遣いは Firefox Developer Edition、脆弱性診断は通常の Firefox でやるように使い分けている
	- こういう分け方をしておくと Raycast のショートカットキーを別々に定義できて便利
	- Command+Option+m で Firefox Developer Edition を起動 (Mozilla 製品なので m)
	- Command+Option+f で通常の Firefox  を起動 (Firefox なので f)
- DeepL のエクステンションを有効化すると一部のアプリケーションでテキストボックスがバグることがあったので入れてない
	- DeepL はデスクトップアプリケーション経由で使っている
