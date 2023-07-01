#!/bin/bash
set -e

read -r -p "Enter Server FQDN": server_fqdn

issuer_certificate="data/intermediateCA.crt"
issuer_certificate_chain="data/intermediateCA_chain.crt"
issuer_private_key="data/intermediateCA.key"

openssl genrsa -aes256 -out "data/client-${server_fqdn}.key" 8192

cat <<EOT >"data/client-${server_fqdn}.csr.cnf"
[ req ]
distinguished_name	=	req_distinguished_name
default_md			=	sha256
prompt				=	no
req_extensions		=	v3_req

[ req_distinguished_name ]
CN	=	${server_fqdn}

[ v3_req ]
basicConstraints		=	critical,CA:FALSE
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment
extendedKeyUsage		=	critical,clientAuth
subjectAltName          =   @alt_names
[alt_names]
DNS.1 = ${server_fqdn}

EOT

openssl req -new -key "data/client-${server_fqdn}.key" \
    -out "data/client-${server_fqdn}.csr" \
    -config "data/client-${server_fqdn}.csr.cnf"

openssl req -in "data/client-${server_fqdn}.csr" -noout -text

cat <<EOT >"data/client-${server_fqdn}.ext.cnf"
[ v3_ca ]
subjectKeyIdentifier	=	hash
authorityKeyIdentifier	=	keyid,issuer
basicConstraints		=	critical,CA:FALSE
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment
extendedKeyUsage		=	critical,clientAuth
subjectAltName          =   @alt_names
[alt_names]
DNS.1 = ${server_fqdn}
EOT

openssl x509 -req -days 1825 -sha256 \
    -in "data/client-${server_fqdn}.csr" -CA "${issuer_certificate}" \
    -CAkey "${issuer_private_key}" -CAcreateserial \
    -out "data/client-${server_fqdn}.crt" \
    -extensions v3_ca -extfile "data/client-${server_fqdn}.ext.cnf"

openssl x509 -in "data/client-$server_fqdn.crt" -text -noout

cat "data/client-${server_fqdn}.crt" "${issuer_certificate_chain}" >"data/client-${server_fqdn}_chain.crt"

rm -rf "data/client-${server_fqdn}.ext.cnf" "data/client-${server_fqdn}.csr.cnf" "data/client-${server_fqdn}.csr"

openssl pkcs12 -export -out "data/client-${server_fqdn}_chain.p12" \
    -in "data/client-${server_fqdn}_chain.crt" \
    -inkey "data/client-${server_fqdn}.key" #-passin pass:Wrinkle-Reconfirm-Tribunal9 -passout pass:Wrinkle-Reconfirm-Tribunal9
