terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5"
    }
  }
}

resource "github_repository" "testrepo_arpanrecme" {
  name               = "testrepo_arpanrecme"
  auto_init          = true
}
