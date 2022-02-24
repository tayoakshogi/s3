resource "aws_s3_bucket" "imports3" {
  bucket = var.bucket_name

  tags = {
    Name                = var.bucket_name
    application         = var.application
    costcenter          = var.costcenter
  }
}

#lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "imports3" {
  bucket = aws_s3_bucket.imports3.id

  rule {
    id = "Glacier_Storage"

    filter {
      prefix = "archive"
    }

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "GLACIER_IR"
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 30
    }

    expiration {
      #days                         = 30
      expired_object_delete_marker = true
    }
  }

}

#Bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "imports3" {
  bucket = aws_s3_bucket.imports3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "imports3" {
  block_public_acls       = true
  block_public_policy     = true
  bucket                  = aws_s3_bucket.imports3.id
  ignore_public_acls      = true
  restrict_public_buckets = true
}


#Bucket Policy
resource "aws_s3_bucket_policy" "imports3" {
  depends_on = [aws_s3_bucket_public_access_block.imports3]
  bucket     = aws_s3_bucket.imports3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid    = "FullReadPolicy"
        Effect = "Allow"
        Principal = {
          AWS = ["${join("\", \"", var.arn_value)}"]
        }
        Action = [
          "s3:*"
        ]
        Resource = [
          aws_s3_bucket.imports3.arn,
          "${aws_s3_bucket.imports3.arn}/*",
        ]
      },
    ]
  })
}

#enforcing Bucket owner feature
resource "aws_s3_bucket_ownership_controls" "imports3" {
  bucket = aws_s3_bucket.imports3.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

#Bucket configuration
resource "aws_s3_bucket_analytics_configuration" "imports3" {
  bucket = aws_s3_bucket.imports3.id
  name   = "s3Analytics_${aws_s3_bucket.imports3.id}"

  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_arn = "arn:aws:s3:::random-bucket"
          format     = "CSV"
          prefix     = "bucket=${aws_s3_bucket.imports3.id}"
        }
      }
    }
  }
}

