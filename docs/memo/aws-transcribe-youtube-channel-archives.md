---
title: AWS Transcribe YouTube Channel Archives
---

## チャンネルの動画一覧ページの DevTools から動画の URL を取得する

<https://www.youtube.com/channel/xxxx/videos>

```js
[...document.querySelectorAll(".yt-simple-endpoint.style-scope.ytd-grid-video-renderer")]
  .map(e =>
    e.href.includes("watch") ?
      new URLSearchParams(new URL(e.href).search).get("v") :
      e.href.match(/\/shorts\/([\w]+)/)[1]
  )
  .map(id => `https://www.youtube.com/watch?v=${id}`)
  .join("\n")
```

`public-video-ids.txt`

```txt
https://www.youtube.com/watch?v=xxxx1
https://www.youtube.com/watch?v=xxxx2
https://www.youtube.com/watch?v=xxxx3
```

## プレイリスト内の動画一覧ページの DevTools から動画の URL を取得する

<https://www.youtube.com/playlist?list=xxxx>

```js
[...document.querySelectorAll(".yt-simple-endpoint.style-scope.ytd-playlist-video-renderer")]
  .map(e =>
    e.href.includes("watch") ?
      new URLSearchParams(new URL(e.href).search).get("v") :
      e.href.match(/\/shorts\/([\w]+)/)[1]
  )
  .map(id => `https://www.youtube.com/watch?v=${id}`)
  .join("\n")
```

`private-video-ids.txt`

```txt
https://www.youtube.com/watch?v=xxxx4
https://www.youtube.com/watch?v=xxxx5
https://www.youtube.com/watch?v=xxxx6
```

## ダウンロードした動画を S3 にアップロード

```sh
aws s3 mb s3://$MP4_BUCKET_NAME

while read -r url; do
  youtube-dl --format mp4 "$url"
  aws s3 cp ./*.mp4 "s3://$MP4_BUCKET_NAME"
  rm ./*.mp4
done <public-video-ids.txt
```

## EC2 を起動

```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0a054d6fbb2cc67ee"
  instance_type = "t2.micro"

  tags = {
    Name = "youtube-backup"
  }
}
```

```sh
terraform init
terraform apply -auto-approve`
```

## Allow SSH from my IP

TODO

## EC2 に SSH してスクリプト実行

<https://dev.classmethod.jp/articles/ec2-instance-connect/>

```sh
sudo apt update -y && sudo apt install -y youtube-dl awscli

curl -sSLO https://raw.githubusercontent.com/lambdasawa/lambdasawa/bba6e3864d5b5721247a6d17da46326fe62ce632/docs/transcribe-channel-archives.md

cp transcribe-channel-archives.md public-video-ids.txt
vim public-video-ids.txt

cp transcribe-channel-archives.md private-video-ids.txt
vim private-video-ids.txt

cp transcribe-channel-archives.md backup.sh
vim backup.sh
chmod u+x backup.sh

./backup.sh
```

### Transcribe を実行

```fish
for key in (aws s3api list-objects-v2 --bucket $MP4_BUCKET_NAME | jq -r ".Contents[] | .Key")
    set video_id (echo $key | sed -E 's/.*\\[(.*)\\].*/\1/')
    set s3_uri "s3://$MP4_BUCKET_NAME/$key"
    set media (printf '{"MediaFileUri":"%s"}' "$s3_uri")

    echo $video_id $s3_uri $media
    aws transcribe start-transcription-job \
        --transcription-job-name "$video_id" \
        --media-format mp4 \
        --language-code ja-JP \
        --media "$media"
end
```

```fish
aws s3 mb s3://$TRANSCRIPT_BUCKET_NAME

mkdir -p transcript
pushd $PWD
cd transcript

for key in (aws s3api list-objects-v2 --bucket $MP4_BUCKET_NAME | jq -r ".Contents[] | .Key")
    set video_id (echo $key | sed -E 's/.*\\[(.*)\\].*/\1/')

  curl -sSL -o "$video_id.json" (aws transcribe get-transcription-job --transcription-job-name $video_id | jq -r .TranscriptionJob.Transcript.TranscriptFileUri)
  aws s3 cp "$video_id.json" s3://$TRANSCRIPT_BUCKET_NAME/

end

popd
```
