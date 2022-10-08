# AWS IAM

## IAM Policy

どういう条件下で何に対してどんな操作が許可/禁止されているかを表すもの。
IAM Role, IAM Group, IAM User にアタッチして使用する。

いくつか種類がある。

- 管理ポリシー (managed policy)
  - カスタマー管理ポリシー
    - AWS のユーザが定義できるポリシー
    - 基本的にはこれを使うと良い
  - AWS 管理ポリシー (ReadOnlyAccess, AdministratorAccess, AmazonS3ReadOnlyAccess など)
    - AWS が事前に用意したポリシー
    - 変更不可
    - 細かい権限を設定したい場合はカスタマー管理ポリシーを作成する
- インラインポリシー (inline policy)
  - 二重管理になりやすいのでカスタマー管理ポリシーを使うべき

その他リファレンス:

- [各フィールドのリファレンス](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/reference_policies_elements.html)
- [Condition で使える式のリファレンス](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/reference_policies_condition-keys.html)
- [各 AWS サービス固有の情報](https://docs.aws.amazon.com/ja_jp/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html)
- [terraform iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
  - [terraform iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)
  - [terraform iam_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)
  - [terraform iam_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment)

## リソースベースポリシー

IAM User, IAM Group, IAM Role などにアタッチはせず、 S3 Bucket などのリソースに設定するポリシー。

一般的には IAM Policy かリソースポリシーのどちらかで許可されていれば操作可能。
ただしアカウントをまたいだ操作の場合は、どちらかではなく両方で許可されている必要がある。

- <https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html>

## IAM Role

主に AWS リソースに対して割り当てるもの。

IAM Policy をアタッチできる。

`sts:AssumeRole` の API を IAM Role に対して呼び出すことによって、 IAM Role にアタッチされたポリシーの権限を持った一時的なアクセスキーを取得できる。

信頼ポリシー (assume role policy、信頼関係) に誰が (どの principal が) この IAM Role を使えるか指定することによって使えるようになる。
principal として代表的なものは、 AWS リソース (`{"Service": ["lambda.amazonaws.com"]}`) 、AWS アカウント (`{"AWS": "123456789012"}`) など。

- [principal の一覧](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/reference_policies_elements_principal.html)
- [terraform iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)

## IAM Group

グループ。部署や役割(開発者、運用担当、管理者など)ごとに1つ。

IAM Policy をアタッチできる。

- [terraform iam_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)
- [terraform iam_user_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership)

## IAM User

個人。一人につき一つ。

IAM Policy をアタッチできる。

AWS のアクセスキーは IAM User に紐づく。
ただし、アクセスキーを発行すること自体が推奨されていない。
可能な限り IAM User のアクセスキーを使用するのではなく、 [IAM Role を使うことが推奨されている](https://docs.aws.amazon.com/ja_jp/general/latest/gr/aws-access-keys-best-practices.html#use-roles)。

IAM Policy を直接ユーザに紐付けることもできるが、二重管理になりやすいので IAM User より IAM Group に IAM Policy を紐付けるべき。

- [terraform iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)
- [terraform iam_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)

## AWS アカウント

数値12桁のアカウント ID で管理される。
個人のものではない。
1つの AWS アカウント内に複数の IAM User, IAM Group, IAM Role などがある。
よくある使い方ではサービスやその環境ごとに1つのアカウントを作る (Hoge サービスの開発環境用アカウント、本番環境用アカウントなど…)。

## AWS Organizations

複数の AWS アカウントをまとめて管理するためのサービス。

## SCP (サービスコントロールポリシー)

TODO

## パーミッションバウンダリー

TODO

## 参考

- リファレンス
  - [イントロダクション](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/introduction.html)
  - [ベストプラクティス](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/best-practices.html)
- Black belt
  - [【AWS Black Belt Online Seminar】AWS Identity and Access Management (AWS IAM) Part1](https://www.youtube.com/watch?v=K7F5yTThynw)
    - [PDF](https://d1.awsstatic.com/webinars/jp/pdf/services/20190129_AWS-BlackBelt_IAM_Part1.pdf)
  - [【AWS Black Belt Online Seminar】AWS Identity and Access Management (AWS IAM) Part2](https://www.youtube.com/watch?v=qrZKKF6V6Dc)
- 関連書籍
  - [AWSの薄い本　IAMのマニアックな話](https://www.amazon.co.jp/dp/B085PZCMG2)
  - [AWSの薄い本Ⅱ アカウントセキュリティのベーシックセオリー](https://www.amazon.co.jp/dp/B08F3BVSJQ)
  - [要点整理から攻略する『AWS認定 セキュリティ-専門知識』 (Compass Booksシリーズ)](https://www.amazon.co.jp/dp/B08DCLRHC7)
