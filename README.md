# tf-github-org-admin
Simple Terraform module to do admin for a GitHub Org.

# Get started

Shell examples are for `bash`.

## Bootstrap

Copy files from bootstrap directory into your repository

```.shell

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
