variable "iam_role" {
  description = "Name of the IAM role to create for Bedrock to use."
  default     = "Bedrock"
}

variable "assume_role_external_id" {
  description = "External ID required for role assumption. Optional."
  default     = null
  type        = string
}
