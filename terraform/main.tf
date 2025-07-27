provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "devsecops-example-bucket-123456"
  acl    = "private"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "your-logging-bucket"
    target_prefix = "log/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"  # Or use "AES256" if not using KMS
        kms_master_key_id = "your-kms-key-id"  # Optional
      }
    }
  }

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}