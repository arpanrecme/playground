resource "github_repository" "new_repo" {
  name               = "new_repo"
  visibility         = "public"
}

data "github_actions_public_key" "gh_actions_public_key" {
  repository = github_repository.new_repo.name
}

# data "sodium_encrypted_item" "encrypted_key" {
#   public_key_base64 = data.github_actions_public_key.gh_actions_public_key.key
#   content_base64    = base64encode("secretpassword")
# }

resource "github_actions_secret" "gh_actions_secret" {
  repository      = github_repository.new_repo.name
  secret_name     = "SECRET_KEY"
  # encrypted_value = data.sodium_encrypted_item.encrypted_key.encrypted_value_base64
  plaintext_value = "mfalksfjalsf"
}
