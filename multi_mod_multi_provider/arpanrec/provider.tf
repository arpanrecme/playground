terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5"
    }
  }
}

resource "github_repository" "testrepo_arpanrec" {
  name               = "testrepo_arpanrec"
  auto_init          = true
}