# Secret Management

## sops

- [github](https://github.com/mozilla/sops)

## Doppler

- <https://docs.doppler.com/docs/cli>

```sh
set name (basename $PWD)
echo -n 'setup:
  project: ${PROJECT_NAME}
  environment: dev
  config: dev
' | env PROJECT_NAME=$name envsubst > doppler.yaml
doppler projects create $name
doppler setup
```

## git-crypt

- [github](https://github.com/AGWA/git-crypt)

## gitleaks

- <https://github.com/zricethezav/gitleaks>

## secretlint

- <https://github.com/secretlint/secretlint>
