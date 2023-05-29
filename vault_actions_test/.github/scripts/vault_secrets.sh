#!/usr/bin/env bash

_global_config=$(curl -s "${GLOBAL_CONFIG_ENDPOINT}")

_vault_proto=$(echo "${_global_config}" | jq -r '.VAULT | .PROTOCOL')
_vault_domain=$(echo "${_global_config}" | jq -r '.VAULT | .FQDN')
_vault_port=$(echo "${_global_config}" | jq -r '.VAULT | .PORT')

_vault_addr="${_vault_proto}://${_vault_domain}:${_vault_port}"

echo "${ROOT_CA_CERTIFICATE}" >"${LOCAL_FILE_ROOT_CA_CERTIFICATE}"
echo "${VAULT_CLIENT_CERT_CHAIN}" >"${LOCAL_FILE_VAULT_CLIENT_CERT_CHAIN}"
echo "${VAULT_CLIENT_KEY}" >"${LOCAL_FILE_VAULT_CLIENT_KEY}"

_approle_auth_payload=$(jq --null-input \
    --arg role_id "$VAULT_APPROLE_ID" \
    --arg secret_id "$VAULT_APPROLE_SECRET_ID" \
    '{"role_id": $role_id, "secret_id": $secret_id}')

curl --request POST --silent \
    "${_vault_addr}"/v1/auth/approle/login \
    --cert "${LOCAL_FILE_VAULT_CLIENT_CERT_CHAIN}" \
    --key "${LOCAL_FILE_VAULT_CLIENT_KEY}" \
    --cacert "${LOCAL_FILE_ROOT_CA_CERTIFICATE}" \
    --header 'Content-Type: application/json' \
    --data-raw "${_approle_auth_payload}" | jq -r '.auth | .client_token' >"${LOCAL_FILE_X_VAULT_TOKEN}"

echo "::add-mask::$(cat "${LOCAL_FILE_X_VAULT_TOKEN}")"

curl --request GET --silent \
    "${_vault_addr}"/v1/prerequisite/data/terraform_cloud \
    --cert "${LOCAL_FILE_VAULT_CLIENT_CERT_CHAIN}" \
    --key "${LOCAL_FILE_VAULT_CLIENT_KEY}" \
    --cacert "${LOCAL_FILE_ROOT_CA_CERTIFICATE}" \
    --header 'Content-Type: application/json' \
    --header "X-Vault-Token: $(cat "${LOCAL_FILE_X_VAULT_TOKEN}")" | jq -r '.data | .data | .TF_PROD_TOKEN' >"${LOCAL_FILE_TF_PROD_TOKEN}"
echo "::add-mask::$(cat "${LOCAL_FILE_TF_PROD_TOKEN}")"
cat "${LOCAL_FILE_TF_PROD_TOKEN}"
