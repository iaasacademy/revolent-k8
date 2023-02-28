resource "aws_dynamodb_table" "dynamodb-table" {
  name         = "${var.project_name}-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  # billing_mode   = "PROVISIONED"
  # read_capacity  = 5
  # write_capacity = 5
  hash_key  = "game_name"
  range_key = "email"

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "game_name"
    type = "S"
  }

  attribute {
    name = "score"
    type = "N"
  }

  local_secondary_index {
    name               = "score-index"
    range_key          = "score"
    projection_type    = "ALL"
    non_key_attributes = []
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_policy" "dynamodb-access" {
  name        = "${var.project_name}-dynamodb-access-${var.environment}"
  path        = "/"
  description = "Allow access to read write on dynamodb table"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query"
        ],
        Effect = "Allow"
        Resource = [
          aws_dynamodb_table.dynamodb-table.arn,
          "${aws_dynamodb_table.dynamodb-table.arn}/index/${element(aws_dynamodb_table.dynamodb-table.local_secondary_index[*].name, 0)}",
        ]
      },
    ]
  })

  tags = {
    Name        = "${var.project_name}-dynamodb-access-${var.environment}"
    Environment = var.environment
  }
}
