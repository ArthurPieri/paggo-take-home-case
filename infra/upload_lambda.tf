
resource "aws_iam_role" "lambda_exec" {
  name = "example_lambda_exec_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "upload_to_s3" {
  function_name    = "upload-to-s3"
  s3_bucket        = "invoice-landing"
  s3_key           = "upload-to-s3.zip"
  role             = "${aws_iam_role.lambda_exec.arn}"
  handler          = "upload.handler"
  runtime          = "nodejs20.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

