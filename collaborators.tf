locals {
  collaboratormap = flatten([
    for user, repos in var.collaborators : [
      for repo in repos : {
        "user" = user
        "repo" = repo
      } if contains(keys(var.repositories), repo) #make sure the repo exists
    ]
  ])
}

resource "github_repository_collaborator" "collaborators" {
  for_each   = { for c in local.collaboratormap : "${c.user}-${c.repo}" => c }
  repository = each.value.repo
  username   = each.value.user
  #permission = each.value.perm # defaults to push
}

