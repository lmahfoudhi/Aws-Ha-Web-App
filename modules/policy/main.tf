resource "aws_iam_role" "iam_role" {
  name = "${var.environment}-${var.id}-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "iam.amazonaws.com"
        }
      }
    ]
  })
  tags = {
      Name        = "${var.environment}-${var.id}-iam-role",
      Environment = var.environment,

      id = var.id
    }
}

resource "aws_iam_policy" "iam_policy" {
  name = "${var.environment}-${var.id}-iam-policy"
  policy = file("../../environments/dev/iam-policies/alb-asg.json")
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}