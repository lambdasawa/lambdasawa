# Docker

## [Dockerfile reference](https://docs.docker.jp/engine/reference/builder.html)

## [Dockerfile best practice](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

## [docker-compose.yml reference](https://docs.docker.jp/compose/compose-file.html)

## [wait](https://github.com/ufoscout/docker-compose-wait)

主に docker-compose と一緒に使うコマンド。他のコンテナのポートが開くのを待つのに使える。
`wait` などを使わずに `depends_on` で依存を指定したときに保証されることはポートが開いていることではなく、あくまでコンテナが起動していることまで。

## [Docker Hub: MySQL](https://hub.docker.com/_/mysql)

## [Docker Hub: Redis](https://hub.docker.com/_/redis)

## [Docker Hub: LocalStack](https://hub.docker.com/r/localstack/localstack)

AWS の各種サービスをローカルでモックできる。

## [Docker Hub: MinIO](https://hub.docker.com/r/minio/minio/)

S3 をモックできる。

## [Docker Hub: MailHog](https://hub.docker.com/r/mailhog/mailhog)

メールをモックできる。

## プラットフォームを指定して docker-compose.yml 内にある全てのイメージを docker pull

```sh
for image in (cat docker-compose.yml | jc --yaml | jq -r '.[0] | .services[] | .image' | grep -v null); docker pull --platform linux/amd64 $image; end
```

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

```sh
$ docker run \
  -itd \
  -p 9200:9200 \
  -p 9300:9300 \
  -e "discovery.type=single-node" \
  docker.elastic.co/elasticsearch/elasticsearch:7.17.1

$ curl -X PUT localhost:9200/foo
```

<https://github.com/abiosoft/colima>
