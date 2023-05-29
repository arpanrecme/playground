terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5"
    }
  }
}

provider "github" {
  alias = "arpanrec"
  owner = "arpanrec"
  token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

provider "github" {
  alias = "arpanrecme"
  owner = "arpanrecme"
  token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

module "arpanrec" {
  source = "./arpanrec"
  providers = {
    github = github.arpanrec
  }
}

module "arpanrecme" {
  source = "./arpanrecme"
  providers = {
    github = github.arpanrecme
  }
}
