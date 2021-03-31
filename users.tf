resource "github_membership" "org_member" {
  for_each = toset([for u in keys(var.users) : u if !contains(lookup(transpose(var.users), var.owner_team, []), u)]) # only users not also owners
  username = each.key
  role     = "member"
}

resource "github_membership" "org_owner" {
  for_each = toset(lookup(transpose(var.users), var.owner_team, [])) # only owners
  username = each.key
  role     = "admin"
}

