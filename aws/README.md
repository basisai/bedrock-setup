# Amazon Web Services

This Terraform module automates the setting up of the IAM role for your AWS Account so that
Bedrock can manage the infrastructure as documented
[here](https://docs.basis-ai.com/onboarding/amazon-web-services-aws/client-infrastructure-requirements).

## Variables

- `iam_role`: (Optional) Name of the IAM role to create for Bedrock to use.
- `assume_role_external_id`: (Optional) External ID to provide to Basis AI for role
  assumption. Click
  [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html) for more information

## Outputs

- `iam_role_arn` - ARN of the IAM role created to provide to Bedrock.
