# required
#github_organization = "MyOrgName"

# To add a user make a new line
# To add a team just add it to the list of users that should be in it
users = {
  #"User1" = ["owners", "contributors", "admins"]
  #"User2" = ["owners", "contributors", "admins"]
  #"User3" = ["contributors", "admins"]
  #"User4" = ["contributors", "admins"]
  #"User5" = ["contributors", "admins"]
  #"User6" = ["contributors"]
}

# To add a repository add it as a new key in the map, you should at least add a description
repositories = {
  #"admin-admin" = {
  #  description = "Architecture Decision Records and documentation for Organisation"
  #}
  #"admin-github" = {
  #  description = "Repository where configuration for github is located"
  #}
  #"myRepo" = {
  #  description = "Example application"
  #  has_issues  = true
  #  visibility  = "public"
  #}
}

# For repos where you want to be open, but restrict on single repository
# This will by default add owners from .github/CODEOWNERS file as required reviewers
# Default branch is "main"
branch_protections = {
  #"admin-github" = {
  #  required_pull_request_reviews_dismissal_restrictions = ["admins"]
  #  push_restrictions                                    = ["admins"]
  #}
}

# defaults that will be added to all repositories
default_repo_settings = {
  #pushteams = ["contributors", "admins"]
}

