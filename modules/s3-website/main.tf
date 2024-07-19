locals {
  s3_name = "${var.environment}-${var.bucket_name}"
}

# Create the S3 bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = local.s3_name
}

resource "aws_s3_bucket_acl" "website_bucket_acl" {
  bucket = aws_s3_bucket.website_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Upload the website files
resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.module}/website/", "**/*")
  bucket   = aws_s3_bucket.website_bucket.id
  key      = each.value
  source   = "${path.module}/website/${each.value}"
  etag     = filemd5("${path.module}/website/${each.value}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
}

# Configure the bucket policy
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "${aws_s3_bucket.website_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}

# Local variables for MIME types
locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
  }
}