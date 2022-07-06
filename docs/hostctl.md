# hostctl

<https://guumaster.github.io/hostctl/>

Go 製のコマンドラインツール。
/etc/hosts に行を足したり行を削除したり、グルーピングしてON/OFF を切り替えたりできる。
たまに編集するだけであればテキストエディタで編集すれば良いと思うが、頻繁に編集するフローがあるのであれば hostctl が便利。

## インストール方法

<https://guumaster.github.io/hostctl/docs/installation/>

## Hello, hostctl

```sh
$ sudo hostctl list
+----------+--------+-----------------+----------------------------+
| PROFILE  | STATUS |       IP        |           DOMAIN           |
+----------+--------+-----------------+----------------------------+
| default  | on     | 127.0.0.1       | localhost                  |
| default  | on     | 255.255.255.255 | broadcasthost              |
| default  | on     | ::1             | localhost                  |
| default  | on     | 127.0.0.1       | kubernetes.docker.internal |
+----------+--------+-----------------+----------------------------+
```

## バックアップ

hostctl コマンドで色々編集する前に、現時点の /etc/hosts をバックアップとしてどこかに置いといた方が良い。

```sh
$ hostctl backup
[✔] Backup 'hosts.20220307' created.

+---------+--------+-----------------+----------------------------+
| PROFILE | STATUS |       IP        |           DOMAIN           |
+---------+--------+-----------------+----------------------------+
| default | on     | 127.0.0.1       | localhost                  |
| default | on     | 255.255.255.255 | broadcasthost              |
| default | on     | ::1             | localhost                  |
| default | on     | 127.0.0.1       | kubernetes.docker.internal |
+---------+--------+-----------------+----------------------------+
```

これでカレントディレクトリに /etc/hosts のコピーが作成される。

リストアを行うコマンドもある。

```sh
sudo hostctl restore --from ./hosts.20220307
```

## 行の追加

構文

```sh
sudo hostctl add domains プロファイル名 ドメイン名(スペース区切りで1個以上)
```

例

```sh
$ sudo hostctl add domains my-app my-server-1 my-server-2
[✔] Domains 'my-server-1, my-server-2' added.

+---------+--------+-----------+-------------+
| PROFILE | STATUS |    IP     |   DOMAIN    |
+---------+--------+-----------+-------------+
| my-app  | on     | 127.0.0.1 | my-server-1 |
| my-app  | on     | 127.0.0.1 | my-server-2 |
+---------+--------+-----------+-------------+

$ cat /etc/hosts
## ... 省略 ...
## profile.on my-app
127.0.0.1 my-server-1
127.0.0.1 my-server-2
## end
```

ファイルからまとめて入力することができる。

```sh
$ cat .etchosts
127.0.0.1       my-server-42
127.0.0.1       my-server-43

$ sudo hostctl add my-app < .etchosts
+---------+--------+-----------+--------------+
| PROFILE | STATUS |    IP     |    DOMAIN    |
+---------+--------+-----------+--------------+
| my-app  | on     | 127.0.0.1 | my-server-42 |
| my-app  | on     | 127.0.0.1 | my-server-43 |
+---------+--------+-----------+--------------+

$ cat /etc/hosts
## ... 省略 ...
## profile.on my-app
127.0.0.1 my-server-42
127.0.0.1 my-server-43
## end
```

プロジェクトごとに使う設定が決まっているなら `.etchosts` を git 管理して、  npm の `preinstall` にこのコマンドを入れたりしても良いと思う。

## 行の削除

構文

```sh
sudo hostctl remove domains プロファイル名 ドメイン名(スペース区切りで1個以上)
```

例

```sh
$ sudo hostctl remove domains my-app my-server-1
[✔] Domains 'my-server-1' removed.

+---------+--------+-----------+-------------+
| PROFILE | STATUS |    IP     |   DOMAIN    |
+---------+--------+-----------+-------------+
| my-app  | on     | 127.0.0.1 | my-server-2 |
+---------+--------+-----------+-------------+

## cat /etc/hosts
## ... 省略 ...
## profile.on my-app
127.0.0.1 my-server-2
## end
```

プロファイルをまるごと削除することもできる。

構文

```sh
sudo hostctl remove プロファイル名
```

例

```sh
$ sudo hostctl remove my-app
[✔] Profile(s) 'my-app' removed.
```

プロファイルを一つしか扱わないなら、こういうエイリアスを設定しておくのも便利。

```sh
alias domainadd='sudo hostctl add domain my-app'
domainadd foo
```

## プロファイルの有効化と無効化

プロファイルごとに設定を一時的に無効化することができる。

操作前

```sh
$ sudo hostctl list
+----------+--------+-----------------+----------------------------+
| PROFILE  | STATUS |       IP        |           DOMAIN           |
+----------+--------+-----------------+----------------------------+
| default  | on     | 127.0.0.1       | localhost                  |
| default  | on     | 255.255.255.255 | broadcasthost              |
| default  | on     | ::1             | localhost                  |
| default  | on     | 127.0.0.1       | kubernetes.docker.internal |
+----------+--------+-----------------+----------------------------+
| my-app-1 | on     | 127.0.0.1       | my-server-1                |
+----------+--------+-----------------+----------------------------+
| my-app-2 | on     | 127.0.0.1       | my-server-1                |
+----------+--------+-----------------+----------------------------+
```

無効化

```sh
$ sudo hostctl disable my-app-1
+----------+--------+-----------+-------------+
| PROFILE  | STATUS |    IP     |   DOMAIN    |
+----------+--------+-----------+-------------+
| my-app-1 | off    | 127.0.0.1 | my-server-1 |
+----------+--------+-----------+-------------+

$ cat /etc/hosts
## ... 省略 ...
## profile.off my-app-1
## 127.0.0.1 my-server-1    ## ここがコメントアウトされてる
## end

## profile.on my-app-2
127.0.0.1 my-server-1
## end
```

有効化

```sh
$ sudo hostctl enable my-app-1
+----------+--------+-----------+-------------+
| PROFILE  | STATUS |    IP     |   DOMAIN    |
+----------+--------+-----------+-------------+
| my-app-1 | on     | 127.0.0.1 | my-server-1 |
+----------+--------+-----------+-------------+


$ cat /etc/hosts
## ... 省略 ...
## profile.off my-app-1
127.0.0.1 my-server-1 
## end

## profile.on my-app-2
127.0.0.1 my-server-1
## end
```

## 一時的なプロファイルを作る

プロファイルとドメインを作成 → 他の作業 → プロファイルを削除というフローがあるなら、`add` コマンドに `--wait 0` オプションを使うのが良い。
これを使うと `/etc/hosts` を更新した後にキー入力を受け付ける状態になって、 Ctrl+c を押すと `/etc/hosts` がコマンド実行前の状態に戻る。

```sh
$ sudo hostctl add domains my-tmp my-server-1 --wait 0
[✔] Domains 'my-server-1' added.

+---------+--------+-----------+-------------+
| PROFILE | STATUS |    IP     |   DOMAIN    |
+---------+--------+-----------+-------------+
| my-tmp  | on     | 127.0.0.1 | my-server-1 |
+---------+--------+-----------+-------------+

[ℹ] Waiting until ctrl+c to remove domains from profile 'my-tmp, my-server-1'


^C
[✔] Profile 'my-tmp' removed.
```

キー入力をせずに一定時間後に削除して良いなら `--wait` に `0` 以外の値を渡せば良い。
`sudo hostctl add domain my-tmp my-server-1 --wait 60` を実行すると60秒間だけ `my-server-1` というホスト名が使える状態になり、60秒後にそれが使えなくなる。
