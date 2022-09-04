# amplify-cfn-dynamic-reference

- <https://docs.amplify.aws/start/getting-started/data-model/q/integration/react/#create-a-graphql-api-and-database>
- <https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/dynamic-references.html#dynamic-references-ssm-secure-strings>
- <https://techblog.zozo.com/entry/pass_secrets_to_cloudformation>

```sh
aws secretsmanager create-secret --name lamb-sbx-amplify-cfn-dynamic-reference --secret-string '{"HOGE_API_KEY":"foo"}'
```
