resource "aws_s3_object" "armageddon_repo_link" {
  bucket       = aws_s3_bucket.gcheck-bucket.id
  key          = "armageddon_repo_link.md"
  source       = "./objects/armageddon_repo_link.md"
  content_type = "text/markdown"
}

# resource "aws_s3_object" "pipeline-succes" {
#   bucket       = aws_s3_bucket.class7-gcheck.bucket
#   key          = "pipeline_success.png"
#   source       = "./proof/pipeline_success.png"
#   content_type = "image/png"

#   etag = filemd5("./proof/pipeline_success.png")
# }

# resource "aws_s3_object" "webhook" {
#   bucket       = aws_s3_bucket.class7-gcheck.bucket
#   key          = "webhook.png"
#   source       = "./proof/webhook.png"
#   content_type = "image/png"

#   etag = filemd5("./proof/webhook.png")
# }

# resource "aws_s3_object" "s3_bucket_images" {
#   bucket       = aws_s3_bucket.class7-gcheck.bucket
#   key          = "s3_bucket_images.png"
#   source       = "./proof/s3_bucket_images.png"
#   content_type = "image/png"

#   etag = filemd5("./proof/s3_bucket_images.png")
# }

resource "aws_s3_bucket_public_access_block" "gcheck-public-access" {
  bucket = aws_s3_bucket.gcheck-bucket.id

  block_public_acls  = true
  ignore_public_acls = true

  block_public_policy     = false
  restrict_public_buckets = false
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
}