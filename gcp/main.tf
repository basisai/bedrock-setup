terraform {
  required_version = "~> 0.12.6"
}

provider "google" {
  project = var.project
}

resource "google_project_service" "apis" {
  for_each = local.apis

  service = each.key

  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_iam_member" "bedrock" {
  for_each = local.bedrock_roles

  role   = each.key
  member = local.bedrock_manager
}

locals {
  apis = toset([
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
  ])

  bedrock_manager = "group:bedrock-deployment@basis-ai.com"

  bedrock_roles = toset([
    "roles/editor",
    "roles/resourcemanager.projectIamAdmin",
  ])
}
