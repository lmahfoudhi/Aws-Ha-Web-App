
resource "aws_s3_bucket" "state_lock_bucket" {
  bucket = "${var.environment}-${var.id}-s3-bucket"

  tags = {
    Name        = "${var.environment}-${var.id}-s3-bucket"
    Environment = var.environment,
    id          = var.id
  }

}

resource "aws_dynamodb_table" "state_lock_table" {
  name         = "${var.environment}-${var.id}-dynamodb-table"
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }

  tags = {
    Name        = "${var.environment}-${var.id}-dynamodb-table"
    Environment = var.environment,
    id          = var.id
  }


}