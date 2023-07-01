###############################################################################################################################################################################
###############################################################################################################################################################################
###############################################################################################################################################################################


openssl genrsa -out intermediateCA.key

cat <<EOT > intermediateCA.csr.cnf
[ req ]
distinguished_name	=	req_distinguished_name
default_md			=	sha256
prompt				=	no
req_extensions		=	v3_req

[ req_distinguished_name ]
CN	=	Source Shift Intermediate Vault CA V1

[ v3_req ]
basicConstraints	=	critical,CA:TRUE,pathlen:0
keyUsage			=	critical,digitalSignature,keyEncipherment,keyCertSign,cRLSign
extendedKeyUsage	=	critical,serverAuth

EOT

openssl req -new -key intermediateCA.key -out intermediateCA.csr -config intermediateCA.csr.cnf

openssl req -in intermediateCA.csr -noout -text

cat <<EOT > intermediateCA.ext.cnf
[ v3_ca ]
subjectKeyIdentifier	=	hash
authorityKeyIdentifier	=	keyid,issuer
#basicConstraints		=	critical,CA:TRUE,pathlen:0
#keyUsage				=	critical,digitalSignature,keyEncipherment,keyCertSign,cRLSign
#extendedKeyUsage		=	critical,serverAuth
basicConstraints		=	critical,CA:TRUE
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyCertSign,cRLSign
extendedKeyUsage		=	critical,serverAuth,clientAuth,codeSigning,emailProtection,timeStamping,OCSPSigning,msCTLSign,msEFS

EOT

openssl x509 -req -days 1825 -sha256 -in intermediateCA.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out intermediateCA.crt -extensions v3_ca -extfile intermediateCA.ext.cnf

openssl x509 -in intermediateCA.crt -text -noout
