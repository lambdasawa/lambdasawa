# yt-dlp

```sh
brew install yt-dlp/taps/yt-dlp
```

## スケジュールされた配信を10秒おきにポーリングして、配信が開始されたらダウンロード開始

```sh
yt-dlp --wait-for-video 10 'https://www.youtube.com/watch?v=xxxx'
```

## mp3 でダウンロード

```sh
yt-dlp --extract-audio --audio-format mp3 'https://www.youtube.com/watch?v=xxxx'
```

## チャットだけ取得

```sh
yt-dlp --write-subs --no-download 'https://www.youtube.com/watch?v=xxxx'
cat *.json | jq -s
```

## コメントだけ取得

```sh
yt-dlp --write-comment --no-download 'https://www.youtube.com/watch?v=xxxx'
cat *.json | jq -s
```

## 配信のチャットをダウンロードしてスパチャの合計額 (JPYのみ) を集計

```sh
yt-dlp --write-subs --no-download 'https://www.youtube.com/watch?v=xxxx'
cat *live_chat.json | jq -s | gron | grep 'purchaseAmountText.simpleText' | sed -E 's/.*= "(.*)".*/\1/g' | sed -E 's/[¥,]//g' | paste -s -d+ - | bc
```
