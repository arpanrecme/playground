terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
    sodium = {
      source  = "killmeplz/sodium"
      version = ">= 0.0.3"
    }
  }
}

provider "github" {
  owner = "arpanrec"
  token = var.GH_PROD_API_TOKEN
}
