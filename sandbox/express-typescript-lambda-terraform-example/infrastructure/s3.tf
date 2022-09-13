resource "aws_s3_bucket" "main" {
  bucket = "${local.project}-main-${var.stage}"

  tags = local.tags
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id

  acl = "private"
}
