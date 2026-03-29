resource "aws_s3_bucket" "gcheck-bucket" {
  bucket_prefix = "gcheck-bucket"
  force_destroy = true

  tags = {
    Name = "gcheck bucket"
  }
}