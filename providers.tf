# Configure the GitHub Provider
#provider "github" {
#  token        = var.github_token
#  organization = var.github_organization
#}

terraform {
  required_providers {
    github = {
      source  = "hashicorp/github"
      version = ">= 4.6.0"
    }
  }
  required_version = ">= 0.14.4"
}

