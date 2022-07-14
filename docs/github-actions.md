# GitHub Actions

## syntax

<https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions>

## cache

<https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows>

## service container

ジョブごとにバックグラウンドで動作するコンテナを指定できる。
ユニットテストが DB などを必要としているケースなどで便利。

<https://docs.github.com/en/actions/using-containerized-services/about-service-containers>

## dynamic value

GitHub Actions では式を書ける。

主なユースケース:

- ステップに `if` を書いて特定のブランチでだけ実行する
- キャッシュキーを計算するために `hashFiles` 関数を使う
- GitHub のアクセストークンを `env` で `secrets.GITHUB_TOKEN` として指定する

<https://docs.github.com/en/actions/learn-github-actions/expressions>
<https://docs.github.com/en/actions/learn-github-actions/contexts>

## environment variables

<https://docs.github.com/en/actions/learn-github-actions/environment-variables>

## workflow command

他のステップにパラメータを渡したり、赤いログを出したり、 PATH を追加したり…そういう操作がワークフローコマンドとして実行できる。

<https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions>

アクションを作るときに参照するべきドキュメント

## JS or TS action

<https://docs.github.com/en/actions/creating-actions/creating-a-javascript-action>

<https://github.com/actions/toolkit>

## Docker action

<https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action>

## composite action

シェルスクリプトのみ、他のアクションとの組み合わせなどで作るとき。

<https://docs.github.com/en/actions/creating-actions/creating-a-composite-action>

## debug

### local

<https://github.com/nektos/act>

ローカルでワークフローファイルを実行できるエミュレータ的な CLI。

デフォルトでは実際の GitHub Actions 環境との差分が多いが [Runner として使う Docker イメージを指定できる](
https://github.com/nektos/act#use-an-alternative-runner-image)ので、そのオプションを使うと似たような環境で実行できる。

### ssh

<https://github.com/mxschmitt/action-tmate>

<https://github.com/rhysd/actionlint>

AWS との連携

<https://github.com/aws-actions/configure-aws-credentials#assuming-a-role>

OIDC で AWS と GitHub を連携させることによって、 IAM User ではなく IAM Role でデプロイなどできる。
IAM Role を使うことによって管理するアクセスキーを減らせる。

`on: workflow_call`

<https://docs.github.com/en/actions/using-workflows/reusing-workflows>

このトリガーを設定しておくと別のワークフローからそのワークフローを呼び出せる。
呼び出し側は `job` の `uses` にワークフローを指定することで呼び出す。

呼び出される側 (`.github/workflows/workflow-call-callee.yml`)

```yaml
on:
  workflow_call:
    inputs:
      username:
        required: true
        type: string
    secrets:
      PAT:
        required: true

jobs:
  callee:
    runs-on: ubuntu-latest
    steps:
      - run: echo "${{ inputs.username }} ${{ secrets.PAT }}"
```

呼び出し側 (`.github/workflows/foo.yml`)

```yaml
on: # ... 省略 ...

jobs:
  foo:
    uses: ./.github/workflows/workflow-call-callee.yml
    with:
      username: alice
    secrets:
      PAT: alice-secret
```

composite action

<https://docs.github.com/en/actions/creating-actions/creating-a-composite-action>

複数の `step` を組みわせて一つの `action.yml` として扱うことができる。
呼び出し側は `step` の `users` に `action.yml` のディレクトリを渡すことができる。

呼び出される側 (`custom-action/composite/action.yml`)

```yaml
name: "My Composite Action"
description: "Execute awesome steps"
inputs:
  name:
    required: true
    default: "world"
outputs:
  time:
    value: ${{ steps.now.outputs.time }}
runs:
  using: "composite"
  steps:
    - run: echo Hello ${{ inputs.name }}.
      shell: bash

    - id: now
      run: echo "::set-output name=time::$(date +%s)"
      shell: bash
```

呼び出し側 (`.github/workflows/foo.yml`)

```yaml
on: # ... 省略 ....

jobs:
  foo:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - id: hello
        uses: ./custom-action/composite
        with:
          name: "lambdasawa"

      - run: echo "${{ steps.hello.outputs.time }}"
```

`on: workflow_run`

<https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_run>

このトリガーを設定しておくと他のワークフローの開始か終了をトリガーにしたワークフローを作成できる。
終了をトリガーにする場合、 `github.event.workflow_run.conclusion` を参照することでトリガー元のワークフローが成功したか失敗したかを判断できる。

呼び出される側 (`.github/workflows/foo.yml`)

```yaml
on:
  workflow_run:
    workflows: [workflow-run-source]
    types:
      - completed

jobs:
  foo:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - run: echo "Hello, ${{ github.event.workflow_run.conclusion }}"
```

呼び出す側 (`.github/workflows/bar.yml`)

```yaml
name: workflow-run-source

on: # … 省略 ...

jobs:
  foo:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - run: echo "Hello, world!"
```

`on: repository_dispatch`

<https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch>
<https://docs.github.com/en/rest/reference/repos#create-a-repository-dispatch-event>

このトリガーを設定しておくと GitHub の API 経由でワークフローを起動できる。
Personal Access Token か GitHub App 経由で呼び出せる。

```yml
on:
  repository_dispatch:
    types: [my-type]

jobs:
  foo:
    runs-on: ubuntu-latest
    steps:
      - run: echo $VALUE
        env:
          VALUE: ${{ github.event.client_payload.value }}
```

`gh api` コマンドで PAT を使って呼び出す例

```sh
echo '{"event_type": "my-type", "client_payload": {"value": 42}}' |
  gh api \
    -X POST \
    /repos/lambdasawa/github-actions-sandbox/dispatches \
    -H 'Accept: application/vnd.github.v3.raw+json' \
    --input -
```

`on: workflow_dispatch`

<https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch>

このトリガーを設定しておくと GitHub の Actions のページか `gh` コマンドから手動でワークフローを起動できる。

```yml
on:
  workflow_dispatch:
    inputs:
      stringValue:
        description: "desc1"
      booleanValue:
        description: "desc2"
        required: true
        type: boolean
      choiceValue:
        description: "desc3"
        required: true
        default: "green"
        type: choice
        options:
          - red
          - green
          - blue
      envValue:
        description: "desc4"
        type: environment
        required: true

jobs:
  foo:
    runs-on: ubuntu-latest
    environment: ${{ github.event.inputs.envValue }}
    steps:
      - run: |
          echo ${{ github.event.inputs.stringValue }}
          echo ${{ github.event.inputs.booleanValue }}
          echo ${{ github.event.inputs.choiceValue }}
          echo ${{ github.event.inputs.envValue }}
```

`gh workflow run` コマンドで呼び出す例

```sh
gh workflow run workflow-dispatch.yml -f stringValue=foo -f booleanValue=true -f envValue=develop
```

environment

<https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment>
<https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idenvironment>

レポジトリごとに環境を複数登録できる。
それぞれの環境は異なるシークレットを設定できる。

```yaml
name: environment-staging

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    environment: staging # ここで環境を指定する
    steps:
      - uses: actions/checkout@v2
      - run: |
          echo "$MY_SECRET" | sha256sum
        env:
          MY_SECRET: ${{ secrets.MY_SECRET }}
```

<https://github.com/actions/github-script>

ワークフローのステップを JS で書ける。
GitHub の API を叩いたり (`github` を使う)、ワークフローコマンド相当の処理をしたり (`core` を使う) するのが楽。

## refactor workflow

- ワークフロー内にあるパラメータを少し変えて複数パターンで実行したい場合は `workflow_call` が使える
- ワークフローの開始か終了をトリガーにして別のワークフローを起動をする場合は `workflow_run` が使える
- あるワークフローから別のワークフローの一部分のステップだけを使いたい場合は、 そのステップを composite action として切り出せる
- `secrets.GITHUB_TOKEN` を使って `git push`, `gh pr merge` しても `push` のトリガーは発火しない
- 同様に `secrets.GITHUB_TOKEN` を使って `gh workflow run` しても `workflow_dispatch` のトリガーは発火しない
- 上記のような `secrets.GITHUB_TOKEN` で動作しないケースでは代わりに Personal Access Token を使うと動作する

<https://stackoverflow.com/questions/67550727/push-event-doesnt-trigger-workflow-on-push-paths-github-actions>

<https://github.com/slackapi/slack-github-action>
