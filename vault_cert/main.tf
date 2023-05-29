terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
  }
}
variable "VAULT_APPROLE_ID" {}
variable "VAULT_APPROLE_SECRET_ID" {}
provider "vault" {
  address      = "https://172-105-47-176.ip.linodeusercontent.com:8200"
  ca_cert_file = "root_ca_certificate.pem"
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = var.VAULT_APPROLE_ID
      secret_id = var.VAULT_APPROLE_SECRET_ID
    }
  }
  client_auth {
    cert_file = "vault_client_cert_chain.pem"
    key_file  = "vault_client_key.pem"
  }
}
resource "vault_pki_secret_backend_cert" "app" {
  backend     = "pki"
  name        = "vault_client_certificate"
  common_name = "172-105-47-176.ip.linodeusercontent.com"
}
resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = "approle"
  role_name = "scm_cicd"
}

output "total_chain" {
  sensitive = true
  value     = vault_approle_auth_backend_role_secret_id.id
}
