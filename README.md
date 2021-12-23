# tf-github-org-admin
Simple Terraform module to do admin for a GitHub Org.

# Get started

Shell examples are for `bash`.

## Bootstrap

Copy files from bootstrap directory into your repository

```.shell
curl -L https://github.com/tietoevry-devops/tf-github-org-admin/tarball/main | tar -xzv --include '*bootstrap*' --strip-components 2
```

## Edit

Add your Org name and other variables to `terraform.tf`.

Make sure you are referring to the most recent releases in `github-org-admin.tf` and `providers.tf`.

## Create GitHub Personal Access Token (PAT)

Create a PAT for your org owner user.
Add it to your local environment variable `TF_VARS_github_token`

```.shell
export TF_VARS_github_token=xxxxxxxxxxx
```

## Run Terraform

```.shell
terraform plan
```

If you are OK with the proposed changes, run

```.shell
terraform apply
```

# Documentation
<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.4 |
| github | >= 4.18.0 |

## Providers

| Name | Version |
|------|---------|
| github | >= 4.18.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [github_branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) |
| [github_membership](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership) |
| [github_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) |
| [github_repository_collaborator](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborator) |
| [github_team](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) |
| [github_team_membership](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) |
| [github_team_repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| branch\_protections | map of branch protection. any teams with dismissals or push restrictions needs to be explicitly defined with access as well | `map(map(any))` | `{}` | no |
| collaborators | map of external collaborators with list of repositories | `map(list(string))` | `{}` | no |
| default\_branch\_protection\_settings | map of default branch protection. any teams with dismissals or push restrictions needs to be explicitly defined with access as well | `map` | `{}` | no |
| default\_repo\_settings | default repository settings | `map` | `{}` | no |
| github\_organization | n/a | `any` | n/a | yes |
| owner\_team | name of team of owners, the team will be handled especially | `string` | `"owners"` | no |
| repositories | n/a | `any` | <pre>{<br>  "demo": {<br>    "allow_merge_commit": false,<br>    "allow_rebase_merge": false,<br>    "allow_squash_merge": true,<br>    "archive_on_destroy": false,<br>    "auto_init": true,<br>    "delete_branch_on_merge": true,<br>    "description": "Demo repository",<br>    "gitignore_template": null,<br>    "has_downloads": false,<br>    "has_issues": false,<br>    "has_projects": false,<br>    "has_wiki": false,<br>    "homepage_url": null,<br>    "is_template": false,<br>    "pushteams": [],<br>    "template": {},<br>    "topics": null,<br>    "visibility": "internal",<br>    "vulnerability_alerts": false<br>  }<br>}</pre> | no |
| users | map of user names with list of teams | `map(list(string))` | `{}` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

