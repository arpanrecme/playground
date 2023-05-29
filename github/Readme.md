# Automation Setup

## Step 1: Accounts Setup

Setup Github code repository and Terraform Cloud

- GitHUB
  - user: arpanrec
  - API Key: GH_PROD_API_TOKEN
- Terraform Cloud
  - organization: arpanrec
  - API Key: TF_PROD_TOKEN
- Ansible Galaxy Account
  - API Key: GALAXY_API_KEY

## Step 2: Create GitHUB initial repositories

- Prerequisite: Install [GitHUB CLI](https://cli.github.com/)

```bash
gh config set git_protocol ssh
gh config set prompt disabled
gh config set editor vim
echo "${GH_PROD_API_TOKEN}" | gh auth login --hostname github.com --with-token
```

- Create repository for ansible role: Terraform Cloud Management

```bash
gh repo create ansible-role-terraform-cloud-management --public
echo "${TF_PROD_TOKEN}" | gh secret set --repo arpanrec/ansible-role-terraform-cloud-management TF_PROD_TOKEN
echo "${GALAXY_API_KEY}" | gh secret set --repo arpanrec/ansible-role-terraform-cloud-management GALAXY_API_KEY
```

- Publish ansible role: Terraform Cloud Management to ansible galaxy via Github Actions

- Create repository for ansible playbook: Terraform Cloud Management

```bash
gh repo create ansible-play-terraform-cloud-manage --public
echo "${TF_PROD_TOKEN}" | gh secret set --repo arpanrec/ansible-play-terraform-cloud-manage TF_PROD_TOKEN
```

- Run ansible playbook: Terraform Cloud Management via Github Actions
  - Create terraform organization : arpanrec
  - Create terraform workspace under arpanrec: github_repo_management

- Create repository for terraform github manage, to manage the current github

```bash
gh repo create github-repo-management --public
echo "${TF_PROD_TOKEN}" | gh secret set --repo arpanrec/github-repo-management TF_PROD_TOKEN
echo "${GH_PROD_API_TOKEN}" | gh secret set --repo arpanrec/github-repo-management GH_PROD_API_TOKEN
echo "${GALAXY_API_KEY}" | gh secret set --repo arpanrec/github-repo-management GALAXY_API_KEY
```
