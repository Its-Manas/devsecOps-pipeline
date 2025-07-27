provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "devsecops-example-bucket-123456"
  acl    = "private"
}
