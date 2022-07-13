# yt-dlp

```sh
brew install yt-dlp/taps/yt-dlp
```

## mp4 でダウンロード

```sh
yt-dlp --remux-video mp4 'https://www.youtube.com/watch?v=xxxx'
```

## firefox のクッキーを使って認証を行い mp4 でダウンロード

メン限もダウンロードも可能。

```sh
yt-dlp --cookies-from-browser firefox 'https://www.youtube.com/watch?v=xxxx'
```

## mp4 でダウンロードしてトリミング

75秒目から75+3秒目までをトリミング。

```sh
yt-dlp --remux-video mp4 --exec 'ffmpeg -ss 75 -i %(filepath)q -t 3 -c copy output.mp4' 'https://www.youtube.com/watch?v=xxxx'
```

## スケジュールされた配信を10秒おきにポーリングして、配信が開始されたらダウンロード開始

```sh
yt-dlp --wait-for-video 10 'https://www.youtube.com/watch?v=xxxx'
```

## mp3 でダウンロード

```sh
yt-dlp --extract-audio --audio-format mp3 'https://www.youtube.com/watch?v=xxxx'
```

## mp3 でダウンロードしてトリミング

75秒目から75+3秒目までをトリミング。

```sh
yt-dlp --extract-audio --audio-format mp3 --exec 'sox %(filepath)q output.mp3 trim 75 3' 'https://www.youtube.com/watch?v=xxxx'
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

## 良い感じにダウンロード

```sh
yt-dlp --cookies-from-browser firefox --wait-for-video 10 --remux-video mp4 --write-info-json --write-subs 'https://www.youtube.com/watch?v=xxxx'
```

## 配信のチャットをダウンロードしてスパチャの合計額 (JPYのみ) を集計

```sh
yt-dlp --write-subs --no-download 'https://www.youtube.com/watch?v=xxxx'
cat *live_chat.json | jq -s | gron | grep 'purchaseAmountText.simpleText' | sed -E 's/.*= "(.*)".*/\1/g' | sed -E 's/[¥,]//g' | paste -s -d+ - | bc
```

## クリップのメタデータを取得

```sh
$ yt-dlp -j https://www.youtube.com/clip/xxxx | jq '{start: .section_start, end: .section_end, url: .original_url}'
{
  "start": 20818.6,
  "end": 20833.6,
  "url": "https://www.youtube.com/clip/xxxx"
}
```

## クリップの URL 一覧を取得

```sh
open https://www.youtube.com/feed/clips
```

```js
[...document.querySelectorAll('.yt-simple-endpoint.style-scope.ytd-grid-video-renderer')].map(e => ({link: e.href, title: e.title}))
```
