terraform {
  required_version = "~> 0.12.6"
}

provider "aws" {
  region = "ap-southeast-1" # The region does not matter for IAM resources
}

locals {
  basisai_account_id = "171062276784"

  policies = toset([
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/PowerUserAccess",
  ])
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${local.basisai_account_id}:root",
      ]
    }

    dynamic "condition" {
      for_each = compact([var.assume_role_external_id])

      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [condition.value]
      }
    }
  }
}

resource "aws_iam_role" "bedrock" {
  name        = var.iam_role
  description = "IAM Role for Bedrock to manage infrastructure"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "bedrock" {
  for_each = local.policies

  role       = aws_iam_role.bedrock.name
  policy_arn = each.key
}
