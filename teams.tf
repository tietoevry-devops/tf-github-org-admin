resource "github_team" "teams" {
  for_each = transpose(var.users)
  name     = each.key
  privacy  = "closed"
}

locals {
  membermaps = flatten([
    for user, teams in var.users : [
      for team in teams : {
        "user" = user
        "team" = team
        "role" = contains(lookup(transpose(var.users), var.owner_team, []), user) ? "maintainer" : "member" # org owners are automatically made maintainers by GH
      }
    ]
  ])
}

resource "github_team_membership" "team-member" {
  for_each = { for m in local.membermaps : "${m.user}-${m.team}" => m }
  team_id  = github_team.teams[each.value.team].id
  username = each.value.user
  role     = each.value.role
}

