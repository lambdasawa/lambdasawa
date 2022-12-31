---
title: MySQL
---

- <https://dev.mysql.com/doc/refman/5.6/ja/func-op-summary-ref.html>
- <https://dev.mysql.com/doc/refman/8.0/ja/mysqlpump.html>
- <https://downloads.mysql.com/docs/sakila-db.tar.gz>
- <https://planetscale.com/>
- <https://hub.docker.com/_/mysql>
- <https://www.percona.com/doc/percona-toolkit/LATEST/pt-query-digest.html>

## explain

- [実行計画の読み方](http://nippondanji.blogspot.com/2009/03/mysqlexplain.html)

## import

- [大量データをインポートする際の高速化手法](http://nippondanji.blogspot.com/2010/03/innodb.html)

## general log

コンテナの `general_log` を `tail -f` する。

```sh
$ set u user
$ set p password
$ set n container_name
$ docker exec -it $n bash -c "mysql -u$u -p$p -e \"SET GLOBAL general_log = 'ON';\" 2>/dev/null && echo \"SELECT @@GLOBAL.general_log_file;\" | mysql -u$u -p$p -N 2>/dev/null"
/var/lib/mysql/xxxx.log
$ docker exec -it $n tail -f /var/lib/mysql/xxxx.log
```

### charset

- ref
  - <https://dev.mysql.com/doc/refman/5.6/ja/charset-unicode-utf8mb4.html>
  - <https://dev.mysql.com/doc/refman/8.0/ja/charset-unicode-sets.html>
- [MySQLのencodingをutf8からutf8mb4に変更して寿司ビール問題に対応する](https://techracho.bpsinc.jp/hachi8833/2020_11_26/25044)

### collation

- [ref](https://dev.mysql.com/doc/refman/8.0/ja/charset-collation-names.html)
- [MySQL 8.0のCharset utf8mb4での日本語環境で使うCollationで文字比較をしてみる](https://kazuhira-r.hatenablog.com/entry/2021/05/08/232717)
