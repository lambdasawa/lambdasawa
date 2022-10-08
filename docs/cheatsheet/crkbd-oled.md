# Corne OLED

<https://btoshop.jp/products/adskbcc> で購入した Corne を使いました。

まず適当な画像を用意して ImageMagick で二値化します。
`threshold` は適宜変換後のファイルを目視で確認しながら調整してください。

```sh
convert image.png -threshold 3000 binary_image.png
```

次に横 128px 縦 32px になるように切り抜きます。
以下の例では `-resize 128x128` で 128px の正方形にしてから、 `-crop 128x32+0+64` で縦 64px の位置から 32px 分を切り抜いてます。
つまり画像を縦に4等分したときの真ん中2つを切り抜いてます。

```sh
convert binary_image.png -resize 128x128 -crop 128x32+0+64 small_binary_image.png
```

その画像を [Helix Logo Editor](https://joric.github.io/qle/) にアップロードすると、 OLED にその画像を表示する C の関数が生成されます。
`Font`, `Text`, `Raw` の3つの選択肢がありますが、自分は `Raw` を選択しました。

このコードを `keymap.c` にコピペして、[oled_render_layer_state](https://github.com/qmk/qmk_firmware/blob/46c0db458ee70d5c37a…2a175cc96163713c/keyboards/crkbd/keymaps/default/keymap.c#90) から呼び出します。
各関数の仕様については <https://github.com/qmk/qmk_firmware/blob/master/docs/feature_oled_driver.md> が参考になります。

あとはキーマップを変えるときと同じようにファームウェアのコンパイルとフラッシュを行えば完了です。
