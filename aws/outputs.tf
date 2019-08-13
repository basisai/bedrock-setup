output "iam_role_arn" {
  description = "ARN of the IAM Role for Bedrock to assume"
  value       = aws_iam_role.bedrock.arn
}
