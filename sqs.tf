resource "aws_sqs_queue" "sqs_queue" {
  name                      = "services-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 3600
  receive_wait_time_seconds = 10

  tags = {
    Environment = "production"
    Terraform = "true"
    Name = "fila-sqs-services"
  }
}
