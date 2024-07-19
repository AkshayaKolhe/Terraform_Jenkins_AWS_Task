#tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "s3_website" {
  bucket        = "hellohumans.in"
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.s3_website.id
  versioning_configuration {
    status = "Enabled"
  }
}

#tfsec:ignore:aws-s3-block-public-policy tfsec:ignore:aws-s3-ignore-public-acls tfsec:ignore:aws-s3-no-public-buckets      tfsec:ignore:aws-s3-block-public-acls
resource "aws_s3_bucket_public_access_block" "public_access_s3" {
  bucket = aws_s3_bucket.s3_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "s3_static_hosting" {
  bucket = aws_s3_bucket.s3_website.id

  index_document {
    suffix = "index.html"
  }
}


resource "aws_s3_bucket_policy" "bucket_policy" {
  depends_on = [aws_s3_bucket_public_access_block.public_access_s3]
  bucket     = aws_s3_bucket.s3_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Statement1",
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "${aws_s3_bucket.s3_website.arn}/*"
        ]
      }
    ]
  })
}

resource "null_resource" "upload_website" { #special type of resource in Terraform that doesn't create any actual infrastructure. Instead, it allows you to run provisioners 
  provisioner "local-exec" {                #executed locally on the machine where Terraform is running
    command = "chmod +x ./git-clone.sh && ./git-clone.sh"
  }
  depends_on = [aws_s3_bucket.s3_website] #null_resource should wait for the aws_s3_bucket resource to be created before executing the provisioner.
}