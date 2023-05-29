

terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "3.1.0"
    }
  }
}

provider "http" {
  # Configuration options
}


data "http" "example" {
  url = "https://gitlab.com/arpanrec_user/vault_monorepo/-/raw/main/files/config.json"

  # Optional request headers
  request_headers = {
    Content-Type = "application/json"
  }
}

output "vault_addr" {
  value = jsondecode(data.http.example.response_body).VAULT_ADDR_DOMAIN_NAME
}
