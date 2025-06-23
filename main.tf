module "labels" {
  source      = "cypik/labels/aws"
  version     = "1.0.1"
  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  attributes  = var.attributes
  label_order = var.label_order
}

#tfsec:ignore:aws-sqs-enable-queue-encryption
resource "aws_sqs_queue" "default" {
  count = var.enabled ? 1 : 0

  name                              = var.fifo_queue ? format("%s.fifo", module.labels.id) : module.labels.id
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  message_retention_seconds         = var.message_retention_seconds
  max_message_size                  = var.max_message_size
  delay_seconds                     = var.delay_seconds
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  policy                            = var.policy
  sqs_managed_sse_enabled           = var.sqs_managed_sse_enabled
  redrive_policy                    = var.redrive_policy
  redrive_allow_policy              = var.redrive_allow_policy
  fifo_queue                        = var.fifo_queue
  content_based_deduplication       = var.content_based_deduplication
  deduplication_scope               = var.deduplication_scope
  fifo_throughput_limit             = var.fifo_throughput_limit
  kms_master_key_id                 = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  tags                              = module.labels.tags
}

