openssl genrsa -out vault-dev.sourceshift.org.key 8192

cat <<EOT > vault-dev.sourceshift.org.csr.cnf
[ req ]
distinguished_name	=	req_distinguished_name
default_md			=	sha256
prompt				=	no
req_extensions		=	v3_req

[ req_distinguished_name ]
CN	=	vault-dev.sourceshift.org

[ v3_req ]
basicConstraints	=	critical,CA:FALSE
keyUsage			=	critical,nonRepudiation,digitalSignature,keyEncipherment
extendedKeyUsage	=	critical,serverAuth
subjectAltName		=	DNS:vault-dev.sourceshift.org

EOT

openssl req -new -key vault-dev.sourceshift.org.key -out vault-dev.sourceshift.org.csr -config vault-dev.sourceshift.org.csr.cnf

openssl req -in vault-dev.sourceshift.org.csr -noout -text

cat <<EOT > vault-dev.sourceshift.org.ext.cnf
[ v3_ca ]
subjectKeyIdentifier	=	hash
authorityKeyIdentifier	=	keyid,issuer
basicConstraints		=	critical,CA:FALSE
keyUsage				=	critical,nonRepudiation,digitalSignature,keyEncipherment
extendedKeyUsage		=	critical,serverAuth
subjectAltName			=	DNS:vault-dev.sourceshift.org

EOT

openssl x509 -req -days 365 -sha256 -in vault-dev.sourceshift.org.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out vault-dev.sourceshift.org.crt -extensions v3_ca -extfile vault-dev.sourceshift.org.ext.cnf

openssl x509 -in vault-dev.sourceshift.org.crt -text -noout
