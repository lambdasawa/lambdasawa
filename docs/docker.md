# Docker

## Dockerfile

- [ref](https://docs.docker.com/engine/reference/builder/)
- [ref (ja)](https://docs.docker.jp/engine/reference/builder.html)
- [best practice](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

## docker-compose.yml

- [ref](https://docs.docker.com/compose/compose-file/)
- [ref (ja)](https://docs.docker.jp/compose/compose-file.html)

## wait

- [github](https://github.com/ufoscout/docker-compose-wait)
- 主に docker-compose と一緒に使うコマンド。他のコンテナのポートが開くのを待つのに使える
- `wait` などを使わずに `depends_on` で依存を指定したときに保証されることはポートが開いていることではなく、あくまでコンテナが起動していることまで

## MySQL

- [docker hub](https://hub.docker.com/_/mysql)

```sh
$ cat schema.sql
USE demo;
CREATE TABLE users (
  id bigint PRIMARY KEY
);

$ docker run \
    -itd \
    -p 3306:3306 \
    -v $PWD:/docker-entrypoint-initdb.d/ \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE=demo \
    mysql:8.0

$ mysql -uroot -proot -h127.0.0.1 -P3306 -e 'use demo; show tables;'
```

## Redis

- [docker hub](https://hub.docker.com/_/redis)

## LocalStack

- [docker hub](https://hub.docker.com/r/localstack/localstack)
- AWS の各種サービスをローカルでモックできる

```sh
$ cat init_bucket.sh
set -xeu

export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
aws --endpoint http://127.0.0.1:4566 s3 mb s3://test

$ docker run \
    -itd \
    -p 4566:4566 \
    -p 4571:4571 \
    -v $PWD:/docker-entrypoint-initaws.d/ \
    localstack/localstack

$ env \
    AWS_ACCESS_KEY_ID=test \
    AWS_SECRET_ACCESS_KEY=test \
    aws --endpoint http://127.0.0.1:4566 s3 ls
```

## MinIO

- [docker hub](https://hub.docker.com/r/minio/minio/)
- S3 をモックできる

```sh
$ docker run \
    -itd \
    -p 9000:9000 \
    -p 9001:9001 \
    -e MINIO_ACCESS_KEY=miniokey \
    -e MINIO_SECRET_KEY=miniokey \
    minio/minio server /data --console-address ":9001"

$ export AWS_ACCESS_KEY_ID=miniokey
$ export AWS_SECRET_ACCESS_KEY=miniokey

$ aws --endpoint http://127.0.0.1:9000 s3 mb s3://test
$ aws --endpoint http://127.0.0.1:9000 s3 ls
2022-03-19 22:10:25 test
```

## Elasticsearch

- <https://www.docker.elastic.co/r/elasticsearch>

```sh
$ docker run \
  -itd \
  -p 9200:9200 \
  -p 9300:9300 \
  -e "discovery.type=single-node" \
  docker.elastic.co/elasticsearch/elasticsearch:7.17.1

$ curl -X PUT localhost:9200/foo
```

## MailHog

- [docker hub](https://hub.docker.com/r/mailhog/mailhog)
- メールをモックできる

## プラットフォームを指定して docker-compose.yml に書かれているイメージを全てダウンロード

```sh
for image in (cat docker-compose.yml | jc --yaml | jq -r '.[0] | .services[] | .image' | grep -v null); docker pull --platform linux/amd64 $image; end
```

## Other

<https://github.com/abiosoft/colima>
