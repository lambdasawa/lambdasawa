---
title: Git
---

- [tig](https://jonas.github.io/tig/)
- [ghq](https://github.com/x-motemen/ghq)
- [lefthook](https://github.com/evilmartians/lefthook)

## tips

- [.config/git/alias](https://github.com/lambdasawa/lambdasawa/blob/main/.config/git/alias)

### git setup

git init して git add して git commit する。

### git toplevel

TODO

### gitignore-template

`.gitignore` をテンプレートから生成。

```sh
git gitignore-template >> .gitignore
```

### git ignore

このリポジトリで foo を無視する。

```sh
$ git ignore -p foo

$ cat .gitignore
# 変更なし

$ .config/git/alias
foo
```

### git diff

TODO

### git difft

TODO

### git log

TODO

### git log-difft

TODO

### git wip

TODO

### git pick

TODO

### git sed

TODO

### git prune

TODO

### git prune-hard

TODO

### git abort

rebase, merge, cherry-pick の中止。

### git undo

最新のコミットを削除。

### git current-branch

TODO

### git default-branch

TODO

### git switch-branch

TODO

### git switch-pr

TODO

### git create-branch

TODO

### git delete-branch

TODO

### git rename-branch

TODO

### git fresh-branch

TODO

### git show-merged-branches

TODO

### git show-unmerged-branches

TODO

### git delete-merged-branches

TODO

### git delete-squashed-branches

TODO

### git create-tag

TODO

### git delete-tag

TODO

### git rename-tag

TODO

### git day

TODO

### git week

TODO

### git open-repo

TODO

### git open-pr

TODO

### git review

TODO

### gh workflow

```sh
gh workflow list
gh workflow disable foo.yml
gh workflow enable foo.yml
gh workflow run workflow-dispatch.yml -f stringValue=foo -f booleanValue=true -f envValue=develop
```

### gh run

```sh
gh run list -b main -w metrics.yml
gh run rerun "$id" --failed
gh run watch "$id" --exit-status
```

### gh secret

```sh
gh secret set -f .env
```
