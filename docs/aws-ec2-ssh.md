# AWS EC2 SSH

- [EC2インスタンスへのシェルアクセスサービスを雑にまとめてみた](https://dev.classmethod.jp/articles/choosing-the-right-shell-access-solution-to-aws-ec2)

## Session Manager

```sh
brew install --cask session-manager-plugin
aws ssm start-session --target i-xxxx
```

- <https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html>
- <https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-sessions-start.html>
- <https://github.com/aws/session-manager-plugin>

## Session Manager (SSH)

```sh
brew install --cask session-manager-plugin
ssh -i ~/.ssh/xxx.pem xxx@i-xxx
```

- <https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html>

## Instance Connect

```sh
pip install ec2instanceconnectcli
mssh -r ap-northeast-1 ubuntu@i-xxxx
```

```sh
aws ec2-instance-connect send-ssh-public-key --instance-id i-xxx --availability-zone ap-northeast-1 --instance-os-user ubuntu --ssh-public-key file://$HOME/.ssh/id_rsa.pub
ssh -i ~/.ssh/id_rsa.pub ubuntu@xxx.amazonaws.com
```

- <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-methods.html>
- <https://aws.amazon.com/jp/blogs/compute/new-using-amazon-ec2-instance-connect-for-ssh-access-to-your-ec2-instances/>
- <https://github.com/aws/aws-ec2-instance-connect-cli>
