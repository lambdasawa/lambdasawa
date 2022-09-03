terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {}

resource "aws_s3_bucket" "main" {
  bucket = "lambdasawa-sandbox-terraform-null-resource-local-exec"
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"

  provisioner "local-exec" {
    # upload .gitignore to s3 bucket when bucket created!
    command = "aws s3 cp ./.gitignore s3://${aws_s3_bucket.main.id}/.gitignore"
  }
}

# https://www.terraform.io/language/resources/provisioners/null_resource
# https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource
resource "null_resource" "aws_s3_cp" {
  triggers = {
    bucket_name = aws_s3_bucket.main.id
    file_hash   = sha256(file("main.tf"))
  }

  # https://www.terraform.io/language/resources/provisioners/local-exec
  provisioner "local-exec" {
    # upload main.tf to s3 bucket when main.tf changed
    command = "aws s3 cp ./main.tf s3://${aws_s3_bucket.main.id}/main.tf"
  }
}
