# Configure the GitHub Provider
#provider "github" {
#  token        = var.github_token
#  organization = var.github_organization
#}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 4.18.0"
    }
  }
  required_version = ">= 1.0.4"
}

