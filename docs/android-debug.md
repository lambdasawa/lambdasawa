# Android debug

## adb

まず有線で接続して、 Android の設定画面から USB デバッグとワイヤレスデバッグを有効化。

```sh
adb tcpip 5555 && adb connect x.x.x.x:5555
```

## Android の画面を PC に出す

<https://github.com/Genymobile/scrcpy>

```sh
scrcpy -s x.x.x.x:5555
```

## flutter run

```sh
flutter run -d x.x.x.x
```
