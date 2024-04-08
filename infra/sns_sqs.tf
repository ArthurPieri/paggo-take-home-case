resource "aws_sns_topic" "upload_topic" {
  name = "upload-topic"
}

resource "aws_sns_topic" "read_ocr_topic" {
  name = "read-ocr-topic"
}

resource "aws_sns_topic" "get_metadata_topic" {
  name = "get-metadata-topic"
}

resource "aws_sqs_queue" "upload_queue" {
  name = "upload-queue"
}

resource "aws_sqs_queue" "read_ocr_queue" {
  name = "read-ocr-queue"
}

resource "aws_sqs_queue" "get_metadata_queue" {
  name = "get-metadata-queue"
}

resource "aws_sns_topic_subscription" "upload_queue_subscription" {
  topic_arn = aws_sns_topic.upload_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.upload_queue.arn
}

resource "aws_sns_topic_subscription" "read_ocr_queue_subscription" {
  topic_arn = aws_sns_topic.read_ocr_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.read_ocr_queue.arn
}

resource "aws_sns_topic_subscription" "get_metadata_queue_subscription" {
  topic_arn = aws_sns_topic.get_metadata_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.get_metadata_queue.arn
}

