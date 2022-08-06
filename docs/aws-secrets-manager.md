# Secrets Manager

## Shell

### 作成

```sh
aws secretsmanager create-secret --name foo --secret-string '{"HOGE_API_KEY":"foo"}'
```

### 値を取得

```sh
aws secretsmanager get-secret-value --secret-id foo | jq -r '.SecretString | fromjson | .HOGE_API_KEY'
```
