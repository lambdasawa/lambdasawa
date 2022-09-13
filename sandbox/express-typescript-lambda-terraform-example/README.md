# express-typescript-lambda-terraform-example

## Prerequisite

- [direnv](https://direnv.net/#basic-installation)
- [asdf](https://asdf-vm.com/guide/getting-started.html#getting-started)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS profile configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)
- [watchexec](https://github.com/watchexec/watchexec/tree/main/cli#installation) (for hotswap)

## Setup

```sh
echo 'STAGE=lambdasawa' > .env
direnv allow
asdf install
```

## Deploy

```sh
./script/deploy
```
