terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}


resource "aws_instance" "web" {
  // https://cloud-images.ubuntu.com/locator/ec2/
  ami           = "ami-07b0d532075d92a20"
  instance_type = "t3.micro"

  tags = {
    Name = "sandbox"
  }
}
