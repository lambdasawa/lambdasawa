resource "aws_s3_bucket" "foo" {
  bucket = "terraform-2023-02-19-04-18-45-foo"

  lifecycle {
    ignore_changes = [
      tags_all,
      force_destroy,
    ]
  }
}
