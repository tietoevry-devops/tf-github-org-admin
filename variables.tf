#variable "github_token" {
#}

variable "github_organization" {
}

variable "default_repo_settings" {
  #type    = map(any)
  default     = {}
  description = "default repository settings"
}

variable "default_branch_protection_settings" {
  #type    = map(any)
  default     = {}
  description = "map of default branch protection. any teams with dismissals or push restrictions needs to be explicitly defined with access as well"
}

variable "repositories" {
  type = any
  default = {
    "demo" = {
      description            = "Demo repository"
      homepage_url           = null
      visibility             = "internal"
      has_issues             = false
      has_projects           = false
      has_wiki               = false
      is_template            = false
      allow_merge_commit     = false
      allow_squash_merge     = true
      allow_rebase_merge     = false
      delete_branch_on_merge = true
      has_downloads          = false
      auto_init              = true
      gitignore_template     = null
      archive_on_destroy     = false
      vulnerability_alerts   = false
      topics                 = null
      template               = {}
      pushteams              = []
    }
  }
}

variable "branch_protections" {
  type        = map(map(any))
  default     = {}
  description = "map of branch protection. any teams with dismissals or push restrictions needs to be explicitly defined with access as well"
}

variable "users" {
  type        = map(list(string))
  description = "map of user names with list of teams"
  default     = {}
}

variable "collaborators" {
  type        = map(list(string))
  description = "map of external collaborators with list of repositories"
  default     = {}
}

variable "owner_team" {
  type        = string
  description = "name of team of owners, the team will be handled especially"
  default     = "owners"
}

