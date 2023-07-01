#!/bin/bash
set -e

openssl genrsa -aes256 -out 'data/intermediateCA.key' 8192

issuer_certificate="data/rootCA.crt"
issuer_private_key="data/rootCA.key"

cat <<EOT >'data/intermediateCA.csr.cnf'
[ req ]
distinguished_name	=	req_distinguished_name
default_md			=	sha256
prompt				=	no
req_extensions		=	v3_req

[ req_distinguished_name ]
CN	=	Arpan Vault CA V1

[ v3_req ]
basicConstraints		=	critical,CA:TRUE,pathlen:0
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyCertSign,cRLSign
extendedKeyUsage		=	critical,serverAuth,clientAuth,codeSigning,emailProtection,timeStamping,OCSPSigning,msCTLSign,msEFS

EOT

openssl req -new -key 'data/intermediateCA.key' -out 'data/intermediateCA.csr' -config 'data/intermediateCA.csr.cnf'

openssl req -in 'data/intermediateCA.csr' -noout -text

cat <<EOT >'data/intermediateCA.ext.cnf'
[ v3_ca ]
subjectKeyIdentifier	=	hash
authorityKeyIdentifier	=	keyid,issuer
basicConstraints		=	critical,CA:TRUE,pathlen:0
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyCertSign,cRLSign
extendedKeyUsage		=	critical,serverAuth,clientAuth,codeSigning,emailProtection,timeStamping,OCSPSigning,msCTLSign,msEFS

EOT

openssl x509 -req -days 1825 -sha256 -in 'data/intermediateCA.csr' \
    -CA "${issuer_certificate}" -CAkey "${issuer_private_key}" -CAcreateserial \
    -out 'data/intermediateCA.crt' -extensions v3_ca \
    -extfile 'data/intermediateCA.ext.cnf'

openssl x509 -in 'data/intermediateCA.crt' -text -noout

cat data/intermediateCA.crt data/rootCA.crt >"data/intermediateCA_chain.crt"

rm -rf 'data/intermediateCA.ext.cnf' 'data/intermediateCA.csr.cnf' 'data/intermediateCA.csr' 'data/intermediateCA.srl'
