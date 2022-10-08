# Android

## adb

まず有線で接続して、 Android の設定画面から USB デバッグとワイヤレスデバッグを有効化。

```sh
adb tcpip 5555 && adb connect x.x.x.x:5555
```

## scrcpy

[github](https://github.com/Genymobile/scrcpy)

Android の画面を PC に出してマウスとキーボードで操作できる。

`-s` で IP or デバイスのシリアルを指定できる。

```sh
scrcpy -s x.x.x.x:5555
```

## flutter run

`-d` で IP or デバイスのシリアルを指定できる。

```sh
flutter run -d x.x.x.x
```
