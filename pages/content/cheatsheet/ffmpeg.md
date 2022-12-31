---
title: ffmpeg
---

## トリミング

10 ~ 10+3 秒目まで切り取る例:

```sh
ffmpeg -ss 10 -i input.mp4 -t 3 -c copy output.mp4
```

## 2倍速に変換

```sh
ffmpeg -i input.mp4 -vf setpts=PTS/2.0 -af atempo=2.0 output.mp4
```

## 参考

- [ffmpeg を使うなら知っておきたい話 PTSとかDTSの話：音ずれ問題や時間が変になるときのために ヽ(ﾟｰﾟ*ヽ)(ﾉ*ﾟｰﾟ)ﾉわぁい](https://qiita.com/scleen_x_x/items/7f857f2d08de22dee274)
