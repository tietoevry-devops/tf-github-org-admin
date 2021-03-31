module "github-org-admin" {
  source                             = "github.com/tietoevry-devops/admin-github?ref=v0.1"
  github_token                       = var.github_token
  github_organization                = var.github_organization
  default_repo_settings              = var.default_repo_settings
  default_branch_protection_settings = var.default_branch_protection_settings
  repositories                       = var.repositories
  branch_protections                 = var.branch_protections
  users                              = var.users
  collaborators                      = var.collaborators
  owner_team                         = var.owner_team
}
