# S3

- ref
  - <https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-services-s3-commands.html>
  - <https://docs.aws.amazon.com/cli/latest/reference/s3/index.html#use-of-exclude-and-include-filters>

## ~/.aws/config

- [ref](https://docs.aws.amazon.com/cli/latest/topic/s3-config.html)

```txt
[profile hoge]
s3 =
  max_concurrent_requests = 20
  max_queue_size = 10000
  multipart_threshold = 64MB
  multipart_chunksize = 16MB
  max_bandwidth = 50MB/s
  use_accelerate_endpoint = true
```

## バージョニングされたバケットを削除

```sh
pip install boto3
BUCKET=xxxx python -c 'import os; import boto3; s3 = boto3.resource("s3"); b = s3.Bucket(os.getenv("BUCKET")); b.object_versions.all().delete(); b.delete()'
```

## aws-go-sdk でダウンロード

- [ref](https://github.com/aws/aws-sdk-go/blob/16b6a407abb192af7335d72005c6f08b454f8042/service/s3/s3manager/download.go#L122-L135)

```go
s3Client := s3.New(session.Must(session.NewSession()))
s3Downloader := s3manager.NewDownloaderWithClient(s3Client, func(d *s3manager.Downloader) {
  d.PartSize = 8 * 1024 * 1024
  d.Concurrency = 8
  d.BuffHerProvider = s3manager.NewPooledBufferedWriterReadFromProvider(64 * 1024 * 1024)
})
```

## other

- <https://github.com/minio/minio>
- [Amazon S3の脆弱な利用によるセキュリティリスクと対策](https://blog.flatt.tech/entry/s3_security)
