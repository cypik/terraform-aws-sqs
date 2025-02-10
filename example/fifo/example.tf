provider "aws" {
  region = "us-east-2"
}

module "sqs" {
  source      = "./../../"
  name        = "sqs-fifo"
  environment = "test"
  label_order = ["name", "environment"]

  enabled                     = true
  fifo_queue                  = true
  content_based_deduplication = true
  sqs_managed_sse_enabled     = false
}
