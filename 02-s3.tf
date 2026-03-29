resource "aws_s3_object" "armageddon_repo_link" {
  bucket       = aws_s3_bucket.gcheck-bucket.id
  key          = "armageddon_repo_link.md"
  source       = "./objects/armageddon_repo_link.md"
  content_type = "text/markdown"

  depends_on = [ aws_s3_bucket.gcheck-bucket ]
}

resource "aws_s3_object" "gcheck-pipeline-complete" {
  bucket       = aws_s3_bucket.gcheck-bucket.id
  key          = "gcheck-pipeline-complete.png"
  source       = "./objects/gcheck-pipeline-complete.png"
  content_type = "image/png"

  depends_on = [ aws_s3_bucket.gcheck-bucket ]
}

resource "aws_s3_object" "gcheck-webhook-complete" {
  bucket       = aws_s3_bucket.gcheck-bucket.id
  key          = "gcheck-webhook-complete.png"
  source       = "./objects/gcheck-webhook-complete.png"
  content_type = "image/png"

  depends_on = [ aws_s3_bucket.gcheck-bucket ]
}
resource "aws_s3_bucket_public_access_block" "gcheck-public-access" {
  bucket = aws_s3_bucket.gcheck-bucket.id

  block_public_acls  = true
  ignore_public_acls = true

  block_public_policy     = false
  restrict_public_buckets = false

  depends_on = [ aws_s3_bucket.gcheck-bucket ]
}

resource "aws_s3_bucket_policy" "gcheck-object-policy" {
  bucket = aws_s3_bucket.gcheck-bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicAccess"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.gcheck-bucket.arn}/*"
      }
    ]
  })
  depends_on = [ aws_s3_bucket_public_access_block.gcheck-public-access ]
}