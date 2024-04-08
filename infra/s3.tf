resource "aws_s3_bucket" "invoice_landing" {
  bucket = "invoice-landing"
  acl    = "private"

  tags = {
    Environment = "Dev"
    Name        = "invoice-landing"
  }
}

