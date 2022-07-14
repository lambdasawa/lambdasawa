# op-cli

- [1Password CLI](https://developer.1password.com/docs/cli/)

## signin

```sh
op signin
```

## vault create

```sh
op vault create foo
```

## vault list

```sh
$ op vault list --format json
[
  {
    "id": "xxxx",
    "name": "Personal",
    "content_version": 1
  },
  {
    "id": "yyyy",
    "name": "foo",
    "content_version": 2
  }
]
```

## item create

```sh
op item create --vault foo --title bar --category SecureNote 'default.hoge=fuga'
```

## item edit (put field)

```sh
op item edit --vault foo bar 'default.hoge=FUGA'
```

## item edit (remove field)

```sh
op item edit --vault foo bar 'default.hoge[delete]'
```

## item get

```sh
$ op item get --format json --vault foo bar
{
  "id": "xxxx",
  "title": "bar",
  "version": 4,
  "vault": {
    "id": "xxxx",
    "name": "foo"
  },
  "category": "SECURE_NOTE",
  "last_edited_by": "xxxx",
  "created_at": "2022-07-14T00:07:28Z",
  "updated_at": "2022-07-14T00:08:52Z",
  "sections": [
    {
      "id": "Section_xxxx",
      "label": "default"
    }
  ],
  "fields": [
    {
      "id": "notesPlain",
      "type": "STRING",
      "purpose": "NOTES",
      "label": "notesPlain",
      "reference": "op://foo/bar/notesPlain"
    },
    {
      "id": "xxxx",
      "section": {
        "id": "Section_xxxx",
        "label": "default"
      },
      "type": "CONCEALED",
      "label": "hoge",
      "value": "FUGA",
      "reference": "op://foo/bar/default/hoge"
    }
  ]
}
```

## item get (key value object)

```sh
$ op item get --format json --vault foo bar | jq '.fields[] | select(.label != null and .value != null) | {key: .label, value: .value}' | jq -s 'from_entries'
{
  "fizz": "buzz"
}
```

## run with values as environment variables

```sh
$ cat .env
HOGE=op://foo/bar/default/hoge

$ op run --env-file=.env --no-masking -- printenv HOGE
FUGA
```

## inject values to file

```sh
$ cat config.tmpl.yml
HOGE: op://foo/bar/default/hoge

$ op inject -i config.tmpl.yml -o config.yml
/Users/lambdasawa/src/github.com/lambdasawa/lambdasawa/sandbox/op-cli/config.yml

$ cat config.yml
HOGE: FUGA
```

## set values to GitHub Actions Secret

```sh
$ cat .env
HOGE=op://foo/bar/default/hoge

$ op inject -i .env -o .env.injected

$ gh secret set -f .env.injected
```
