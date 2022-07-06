# transcribe-channel-archives

## <https://www.youtube.com/channel/UCs-lYkwb-NYKE9_ssTRDK3Q/videos>

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
https://www.youtube.com/watch?v=jEXr35AO0AY
https://www.youtube.com/watch?v=mA61eWM4Xrc
https://www.youtube.com/watch?v=PKMwbQkoSo8
https://www.youtube.com/watch?v=hf3sSsNkl9A
https://www.youtube.com/watch?v=bWT2w2ff5WY
https://www.youtube.com/watch?v=Xvf9d3B7V60
https://www.youtube.com/watch?v=rl1BDGd9boo
https://www.youtube.com/watch?v=kUorhrLYBD8
https://www.youtube.com/watch?v=PveOmhKCU70
https://www.youtube.com/watch?v=3eyPV3fmjus
https://www.youtube.com/watch?v=HrKyt6ouZQw
https://www.youtube.com/watch?v=V2bAPFLsrP4
https://www.youtube.com/watch?v=5SXGqK9vZ-I
https://www.youtube.com/watch?v=97Meey8yxEk
https://www.youtube.com/watch?v=H2D3ZUQarAk
https://www.youtube.com/watch?v=15jyV_pN4TY
https://www.youtube.com/watch?v=fYIjBMGenRg
https://www.youtube.com/watch?v=b2c0AbTizAs
https://www.youtube.com/watch?v=u-xoCoYTIdw
https://www.youtube.com/watch?v=4sCpJmj8bzQ
https://www.youtube.com/watch?v=pRW775sDa28
https://www.youtube.com/watch?v=GUcpsy4i9SE
https://www.youtube.com/watch?v=ABzq_M75cFg
https://www.youtube.com/watch?v=kVhp80pVcyo
https://www.youtube.com/watch?v=04oqr8DLoqs
https://www.youtube.com/watch?v=6BPNLt7GDI8
https://www.youtube.com/watch?v=DMbdIPq14ZM
https://www.youtube.com/watch?v=72-yPMS6yHw
https://www.youtube.com/watch?v=JpzHZ1SX_I4
https://www.youtube.com/watch?v=nUqYZgzFyZo
https://www.youtube.com/watch?v=zMpnAQANC0Q
https://www.youtube.com/watch?v=oj_ZJeSylRc
https://www.youtube.com/watch?v=GD6Fkh96P9c
https://www.youtube.com/watch?v=vjAV3oP2THE
https://www.youtube.com/watch?v=UYKLG8qi-aA
https://www.youtube.com/watch?v=f-KyVoXO12Q
https://www.youtube.com/watch?v=c7rWJADwV6M
https://www.youtube.com/watch?v=Tu-CcFn8oyI
https://www.youtube.com/watch?v=OYYBVpFaL7g
https://www.youtube.com/watch?v=3zECT3a4o-o
https://www.youtube.com/watch?v=UqvThCBASiM
https://www.youtube.com/watch?v=gEq11i256Q0
https://www.youtube.com/watch?v=fLM_gBPGNoQ
https://www.youtube.com/watch?v=gUFK6AxOfeM
https://www.youtube.com/watch?v=EkbMVgprFow
https://www.youtube.com/watch?v=umrVIHE9aTU
https://www.youtube.com/watch?v=xJH3uyeJgrU
https://www.youtube.com/watch?v=DMZwO_PzWQg
https://www.youtube.com/watch?v=FHlQf2O8GWQ
https://www.youtube.com/watch?v=G28xPezTG3E
https://www.youtube.com/watch?v=7qAXVa0eWXM
https://www.youtube.com/watch?v=PKwAvrCJczk
https://www.youtube.com/watch?v=Dil0Uas1ukI
https://www.youtube.com/watch?v=UvUZWD8mUkc
https://www.youtube.com/watch?v=MAQ5L_B8cDs
https://www.youtube.com/watch?v=UwHG67ftoFI
https://www.youtube.com/watch?v=CMuez_x3VLw
https://www.youtube.com/watch?v=X7-1CBSr8hA
https://www.youtube.com/watch?v=goj1jeTHDl4
https://www.youtube.com/watch?v=pCuBVVCrtGw
https://www.youtube.com/watch?v=w9Jv1olQ4E4
https://www.youtube.com/watch?v=tHPtp_Lfu_E
https://www.youtube.com/watch?v=oCqrdMUcWB4
https://www.youtube.com/watch?v=fkaY2hCtU0Y
https://www.youtube.com/watch?v=tpr2JAQpX7g
https://www.youtube.com/watch?v=pjr2Kpx5NDo
https://www.youtube.com/watch?v=NqbVnHSBb-g
https://www.youtube.com/watch?v=FMW9l_x39hg
https://www.youtube.com/watch?v=7aQYI5oPT5g
https://www.youtube.com/watch?v=gu-x5zwZR7U
https://www.youtube.com/watch?v=pnxRAjjfF7Q
https://www.youtube.com/watch?v=BTe8pFl3oDo
https://www.youtube.com/watch?v=_l0Fle8lOxM
https://www.youtube.com/watch?v=ftE_w-m-HPU
https://www.youtube.com/watch?v=jG21XLw8Ay8
https://www.youtube.com/watch?v=wTyycKoy2PA
https://www.youtube.com/watch?v=3TpN2mCnU7k
https://www.youtube.com/watch?v=tl9807h6_wY
https://www.youtube.com/watch?v=e_WYvkPMbto
https://www.youtube.com/watch?v=frZl9BL_ykk
https://www.youtube.com/watch?v=jderUn6_3AE
https://www.youtube.com/watch?v=ESu97yHNVqQ
https://www.youtube.com/watch?v=VXz5CxGLQXo
https://www.youtube.com/watch?v=wRcaKs_Vqww
https://www.youtube.com/watch?v=mA6Q7-5HUUk
https://www.youtube.com/watch?v=IuSzOtRaAcw
https://www.youtube.com/watch?v=jxeS9TfrUUA
https://www.youtube.com/watch?v=0cil7WYwguc
https://www.youtube.com/watch?v=sqyscRn3rnU
https://www.youtube.com/watch?v=jHpHPSmthP8
https://www.youtube.com/watch?v=vAPNhStELRk
https://www.youtube.com/watch?v=hGbujjcqyfY
https://www.youtube.com/watch?v=oXwVjSCpRJE
https://www.youtube.com/watch?v=q42l17bwUAs
https://www.youtube.com/watch?v=rsRKrdTIRn4
https://www.youtube.com/watch?v=-MQkR0-Sq6Y
https://www.youtube.com/watch?v=W_unAIrQeF0
https://www.youtube.com/watch?v=8K0ViVRhWnY
https://www.youtube.com/watch?v=5Gm_G1htCjE
https://www.youtube.com/watch?v=aD5Av_7rWac
https://www.youtube.com/watch?v=aHGeOJ6BwsU
https://www.youtube.com/watch?v=MFBaUTq2Jlo
https://www.youtube.com/watch?v=X6AfXZOYbiY
```

## <https://www.youtube.com/playlist?list=PLzWciUjdssNTGXo1A-XAsj5aTGjZ4bMAd>

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
https://www.youtube.com/watch?v=g_ZHIa_4j8c
https://www.youtube.com/watch?v=7bKnHw_k9GU
https://www.youtube.com/watch?v=XWwZGKkx2wA
https://www.youtube.com/watch?v=4XnUt7vfQd0
https://www.youtube.com/watch?v=k3-57hI636k
https://www.youtube.com/watch?v=xm0yYFmkt78
https://www.youtube.com/watch?v=jioSCgaivZM
https://www.youtube.com/watch?v=QEvNpIXaY-Y
https://www.youtube.com/watch?v=jO1HrywwgdA
https://www.youtube.com/watch?v=JKnd7tx9kxA
https://www.youtube.com/watch?v=vg3b7gtgjzg
https://www.youtube.com/watch?v=SBpEed85L5I
https://www.youtube.com/watch?v=9mivHMG1uUU
https://www.youtube.com/watch?v=jVvGbOx_nr0
https://www.youtube.com/watch?v=5TMkvt89NF4
https://www.youtube.com/watch?v=GUB7SGmKFtU
https://www.youtube.com/watch?v=c5mkle_s4Ek
https://www.youtube.com/watch?v=ixN16z9brA4
https://www.youtube.com/watch?v=r1KvNm_RNgQ
https://www.youtube.com/watch?v=4__RuN8qsyA
https://www.youtube.com/watch?v=g_Fbhhsmiyo
https://www.youtube.com/watch?v=us3Dp6Yo3wo
https://www.youtube.com/watch?v=NtFGFYBMkng
https://www.youtube.com/watch?v=c5aBU8qbWIQ
https://www.youtube.com/watch?v=c5aBU8qbWIQ
https://www.youtube.com/watch?v=8-FfHhOiDGI
https://www.youtube.com/watch?v=PEAi9pyQou4
https://www.youtube.com/watch?v=iVoxkW5F4BQ
https://www.youtube.com/watch?v=Ol19teS8rkE
```

## Backup script

```sh
aws s3 mb s3://$MP4_BUCKET_NAME

while read -r url; do
  youtube-dl --format mp4 "$url"
  aws s3 cp ./*.mp4 "s3://$MP4_BUCKET_NAME"
  rm ./*.mp4
done <public-video-ids.txt
```

## Build EC2

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

## SSH

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

### Transcribe

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
