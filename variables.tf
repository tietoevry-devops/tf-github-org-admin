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
  type    = any
  default = {}
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

