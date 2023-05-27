---
title: dsq
---

[usage](https://github.com/multiprocessio/dsq#usage)

CSV, Excel, JSON などに対して SQLite ライクな構文でクエリを発行できる。

```sh
$ http 'https://api.github.com/repos/github/gitignore/git/trees/main?recursive=1' |\
    dsq -s json --pretty 'select path, url from {"tree"} where path regexp "^(Go|Terraform).gitignore"'
+---------------------+--------------------------------------------------------------------------------------------------+
|        path         |                                               url                                                |
+---------------------+--------------------------------------------------------------------------------------------------+
| Go.gitignore        | https://api.github.com/repos/github/gitignore/git/blobs/3b735ec4a8ca017a057cfbc9abc77fe058c12f25 |
| Terraform.gitignore | https://api.github.com/repos/github/gitignore/git/blobs/9b8a46e692b4c85209a91563b4743c52c72b9ca3 |
+---------------------+--------------------------------------------------------------------------------------------------+
(2 rows)

$ http https://api.github.com/repos/github/gitignore/git/blobs/3b735ec4a8ca017a057cfbc9abc77fe058c12f25 |\
    jq -r '.content' |\
    base64 -d
...

# Go workspace file
go.work

...
```
