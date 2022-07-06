# Secret Management

## [mozilla/sops](https://github.com/mozilla/sops)

## [Doppler](https://docs.doppler.com/docs/cli)

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

## [git-crypt](https://github.com/AGWA/git-crypt)

## <https://github.com/zricethezav/gitleaks>

## <https://github.com/secretlint/secretlint>
