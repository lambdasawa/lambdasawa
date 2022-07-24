locals {
  region = "ap-northeast-1"

  tags = {
    Project = "github.com/lambdasawa/lambdasawa/sandbox/terraform-go-serverless"
  }

  s3_origin_id = "MyS3Origin"
}
