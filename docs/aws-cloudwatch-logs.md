# CloudWatch Logs

## Insights query

- [CloudWatch Logs Insight クエリ構文](https://docs.aws.amazon.com/ja_jp/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html)

## cloudwatch-logs-query

- [ref](https://github.com/lambdasawa/lambdasawa/blob/main/bin/cloudwatch-logs-query)

```sh
cloudwatch-logs-query 2022-01-02T03:04:05Z 2023-01-02T03:04:05Z /aws/lambda/foo 'fields @message | limit 5'
```

## utern

- [github](https://github.com/knqyf263/utern)

```sh
utern --no-log-stream --filter '-"START RequestId" -"END RequestId" -"REPORT RequestId"' /aws/lambda/foo
```

## cw

[github](https://github.com/lucagrulla/cw)
