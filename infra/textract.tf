resource "aws_iam_role" "textract_role" {
  name = "textract_service_role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "textract.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

resource "aws_iam_policy" "textract_policy" {
  name        = "TextractLeastPrivilege"
  path        = "/"
  description = "Provides least privilege access to Amazon Textract & S3"

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "textract:AnalyzeDocument",
          "textract:DetectDocumentText"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::invoice-landing/*"
      },
      {
        "Effect": "Allow",
        "Action": "s3:PutObject",
        "Resource": "arn:aws:s3:::output-invoice-landing/*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "textract_role_policy_attach" {
  role       = aws_iam_role.textract_role.name
  policy_arn = aws_iam_policy.textract_policy.arn
}

