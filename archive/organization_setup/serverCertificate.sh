#!/bin/bash
set -e

read -r -p "Enter Server FQDN": server_fqdn

issuer_certificate="data/intermediateCA.crt"
issuer_private_key="data/intermediateCA.key"

openssl genrsa -aes256 -out "data/$server_fqdn.key" 8192

cat <<EOT >"data/$server_fqdn.csr.cnf"
[ req ]
distinguished_name	=	req_distinguished_name
default_md			=	sha256
prompt				=	no
req_extensions		=	v3_req

[ req_distinguished_name ]
CN	=	$server_fqdn

[ v3_req ]
basicConstraints		=	critical,CA:FALSE
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment
extendedKeyUsage		=	critical,serverAuth
subjectAltName          =   @alt_names
[alt_names]
DNS.1 = $server_fqdn

EOT

openssl req -new -key "data/$server_fqdn.key" \
    -out "data/$server_fqdn.csr" \
    -config "data/$server_fqdn.csr.cnf"

openssl req -in "data/$server_fqdn.csr" -noout -text

cat <<EOT >"data/$server_fqdn.ext.cnf"
[ v3_ca ]
subjectKeyIdentifier	=	hash
authorityKeyIdentifier	=	keyid,issuer
basicConstraints		=	critical,CA:FALSE
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment
extendedKeyUsage		=	critical,serverAuth
subjectAltName          =   @alt_names
[alt_names]
DNS.1 = $server_fqdn
EOT

openssl x509 -req -days 1825 -sha256 \
    -in "data/$server_fqdn.csr" -CA "$issuer_certificate" \
    -CAkey "$issuer_private_key" -CAcreateserial \
    -out "data/$server_fqdn.crt" \
    -extensions v3_ca -extfile "data/$server_fqdn.ext.cnf"

openssl x509 -in "data/$server_fqdn.crt" -text -noout

cat "$issuer_certificate" >>"data/$server_fqdn.crt"

rm -rf "data/$server_fqdn.ext.cnf" "data/$server_fqdn.csr.cnf" "data/$server_fqdn.csr"
