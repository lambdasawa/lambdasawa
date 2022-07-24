resource "aws_s3_bucket" "main" {
  bucket = "sandbox-terraform-go-serverless-main"

  tags = local.tags
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}
