locals {
  defaults_repository = { #making sane overwritable defaults
    description            = lookup(var.default_repo_settings, "description", "")
    homepage_url           = lookup(var.default_repo_settings, "homepage_url", null)
    visibility             = lookup(var.default_repo_settings, "visibility", "internal")
    has_issues             = lookup(var.default_repo_settings, "has_issues", false)
    has_projects           = lookup(var.default_repo_settings, "has_projects", false)
    has_wiki               = lookup(var.default_repo_settings, "has_wiki", false)
    is_template            = false
    allow_merge_commit     = lookup(var.default_repo_settings, "allow_merge_commit", false)
    allow_squash_merge     = lookup(var.default_repo_settings, "allow_squash_merge", true)
    allow_rebase_merge     = lookup(var.default_repo_settings, "allow_rebase_merge", false)
    delete_branch_on_merge = lookup(var.default_repo_settings, "delete_branch_on_merge", true)
    has_downloads          = false #deprecated
    auto_init              = lookup(var.default_repo_settings, "auto_init", true)
    gitignore_template     = lookup(var.default_repo_settings, "gitignore_template", null)
    archive_on_destroy     = lookup(var.default_repo_settings, "archive_on_destroy", true)
    vulnerability_alerts   = lookup(var.default_repo_settings, "vulnerability_alerts", true)
    topics                 = lookup(var.default_repo_settings, "topics", null)
    template               = lookup(var.default_repo_settings, "template", {})
    pushteams              = lookup(var.default_repo_settings, "pushteams", [])
    adminteams             = lookup(var.default_repo_settings, "adminteams", [])
  }
}

resource "github_repository" "repos" {
  for_each               = { for name, defs in var.repositories : name => merge(local.defaults_repository, defs) }
  name                   = each.key
  description            = each.value.description
  homepage_url           = each.value.homepage_url
  visibility             = each.value.visibility
  has_issues             = each.value.has_issues
  has_projects           = each.value.has_projects
  has_wiki               = each.value.has_wiki
  is_template            = each.value.is_template
  allow_merge_commit     = each.value.allow_merge_commit
  allow_squash_merge     = each.value.allow_squash_merge
  allow_rebase_merge     = each.value.allow_rebase_merge
  delete_branch_on_merge = each.value.delete_branch_on_merge
  has_downloads          = each.value.has_downloads
  auto_init              = each.value.auto_init
  gitignore_template     = each.value.gitignore_template
  archive_on_destroy     = each.value.archive_on_destroy
  vulnerability_alerts   = each.value.vulnerability_alerts
  topics                 = each.value.topics
  dynamic "template" {
    for_each = length(each.value.template) > 0 ? [1] : []
    content {
      owner      = each.value.template.owner
      repository = each.value.template.repository
    }
  }
}

locals {
  defaults_branch_protection = { #making sane overwritable defaults
    pattern                                                  = lookup(var.default_branch_protection_settings, "pattern", "main")
    enforce_admins                                           = lookup(var.default_branch_protection_settings, "enforce_admins", true)
    require_signed_commits                                   = lookup(var.default_branch_protection_settings, "require_signed_commits", false)
    required_status_checks_strict                            = lookup(var.default_branch_protection_settings, "required_status_checks_strict", true)
    required_status_checks_contexts                          = lookup(var.default_branch_protection_settings, "required_status_checks_contexts", null)
    required_pull_request_reviews_dismiss_stale_reviews      = lookup(var.default_branch_protection_settings, "required_pull_request_reviews_dismiss_stale_reviews", true)
    required_pull_request_reviews_dismissal_restrictions     = lookup(var.default_branch_protection_settings, "required_pull_request_reviews_dismissal_restrictions", null)
    required_pull_request_reviews_require_code_owner_reviews = lookup(var.default_branch_protection_settings, "required_pull_request_reviews_require_code_owner_reviews", true)
    push_restrictions                                        = lookup(var.default_branch_protection_settings, "push_restrictions", null)
    allows_deletions                                         = lookup(var.default_branch_protection_settings, "allows_deletions", null)
    allows_force_pushes                                      = lookup(var.default_branch_protection_settings, "allows_force_pushes", false)
  }
}

resource "github_branch_protection" "branch-protections" {
  for_each               = { for repo, defs in var.branch_protections : repo => merge(local.defaults_branch_protection, defs) }
  repository_id          = github_repository.repos[each.key].name
  pattern                = each.value.pattern
  enforce_admins         = each.value.enforce_admins
  push_restrictions      = [for name in each.value.push_restrictions : github_team.teams[name].node_id]
  allows_deletions       = each.value.allows_deletions
  allows_force_pushes    = each.value.allows_force_pushes
  require_signed_commits = each.value.require_signed_commits

  required_status_checks {
    strict   = each.value.required_status_checks_strict
    contexts = each.value.required_status_checks_contexts
  }

  required_pull_request_reviews {
    dismiss_stale_reviews      = each.value.required_pull_request_reviews_dismiss_stale_reviews
    dismissal_restrictions     = [for name in each.value.required_pull_request_reviews_dismissal_restrictions : github_team.teams[name].node_id]
    require_code_owner_reviews = each.value.required_pull_request_reviews_require_code_owner_reviews
  }
}

locals {
  repoaccess = flatten(concat([
    for name, defs in var.repositories : [
      for team in merge(local.defaults_repository, defs).adminteams : {
        name       = name
        team       = team
        permission = "admin"
      }
    ]
    ],
    [
      for name, defs in var.repositories : [
        for team in merge(local.defaults_repository, defs).pushteams : {
          name       = name
          team       = team
          permission = "push"
        } if !contains(merge(local.defaults_repository, defs).adminteams, name) #cannot be both admin and push
      ]
  ]))
}

resource "github_team_repository" "team_access_repo" {
  for_each   = { for access in local.repoaccess : "${access.name}_${access.team}" => access }
  team_id    = github_team.teams[each.value.team].id
  repository = github_repository.repos[each.value.name].name
  permission = each.value.permission
}

