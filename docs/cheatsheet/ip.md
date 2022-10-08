# IP

## [checkip.amazonaws.com](https://checkip.amazonaws.com/)

グローバル IP を確認できるサイト。

## [db-ip.com](https://db-ip.com/)

```sh
open https://db-ip.com/$(dig github.com | jc --dig | jq -r '.[0].answer[0].data')
```
