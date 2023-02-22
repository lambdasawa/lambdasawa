---
title: GitHub Actions
---

## Hello, world

```yml
name: Hello, world!

on:
  push:

jobs:
  hello-world:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v3

      - run: echo 'Hello, world!'
```

## runs-on に指定できる値

[Workflow syntax for GitHub Actions - GitHub Docs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#jobsjob_idruns-on)

## hosted runner に入っているツール

[About GitHub-hosted runners - GitHub Docs](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#preinstalled-software)


## outputs

[Defining outputs for jobs - GitHub Docs](https://docs.github.com/en/actions/using-jobs/defining-outputs-for-jobs)

```yml
name: output

on:
  workflow_dispatch:

jobs:
  output:
    runs-on: ubuntu-22.04
    steps:
      - id: build-foo
        run: echo foo=bar >> $GITHUB_OUTPUT

      - run: echo $VALUE
        env:
          VALUE: ${{ steps.build-foo.outputs.foo }}
```

## run name

```yml
name: Change run-name

run-name: Custom run-name (actor=${{ github.actor }}, inputs.foo=${{ inputs.foo }})

on:
  workflow_dispatch:
    inputs:
      foo:
        type: string
        description: foo is my input
        required: false

jobs:
  foo:
    runs-on: ubuntu-22.04
    steps:
      - run: echo Hello, world!
```

<https://github.com/lambdasawa/github-actions-sandbox/actions/runs/4247601960/attempts/1>

## job summary

```yml
name: Job Summary

on:
  workflow_dispatch:

jobs:
  job-foo:
    runs-on: ubuntu-22.04
    steps:
      - run: echo '# foo' >> $GITHUB_STEP_SUMMARY

      - run: echo '# bar' >> $GITHUB_STEP_SUMMARY

  job-bar:
    runs-on: ubuntu-22.04
    steps:
      - run: echo '# hoge' >> $GITHUB_STEP_SUMMARY

      - run: echo '# fuga' >> $GITHUB_STEP_SUMMARY
```

<https://github.com/lambdasawa/github-actions-sandbox/actions/runs/4247552065>

## Slack 通知

ref: [slack/README.md at main · integrations/slack](https://github.com/integrations/slack/blob/main/README.md#actions-workflow-notifications)

```txt
/github subscribe owner/repo workflows
```

## その他

- [Push event doesn't trigger workflow on push paths (github actions) - Stack Overflow](https://stackoverflow.com/questions/67550727/push-event-doesnt-trigger-workflow-on-push-paths-github-actions)
