resource "aws_s3_bucket" "foo" {
  bucket = "terraform-2023-02-18-14-59-23-foo"
}

resource "aws_s3_bucket" "hogehoge" {
  bucket = "terraform-2023-02-18-14-59-23-hogehoge"

  lifecycle {
    ignore_changes = [
      tags_all,
      force_destroy,
    ]
  }
}
