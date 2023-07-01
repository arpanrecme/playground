#!/bin/bash
set -ex
openssl genrsa -aes256 -out rootCA.key 8192

cat <<EOT > root.ext.cnf
[ req ]
x509_extensions		=	v3_ca
string_mask			=	utf8only
default_bits		=	8192
prompt				=	no
default_md			=	sha256
distinguished_name	=	req_distinguished_name

[ req_distinguished_name ]
C				=	IN
ST				=	West Bengal
L				=	Arambagh
O				=	arpanrec
OU				=	arpanrec webauth
emailAddress	=	me@arpanrec.com
CN				=	ARPANREC ROOT CA V1

[ v3_ca ]
subjectKeyIdentifier	=	hash
authorityKeyIdentifier	=	keyid,issuer
#basicConstraints		=	critical,CA:TRUE,pathlen:1
basicConstraints		=	critical,CA:TRUE
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyCertSign,cRLSign
extendedKeyUsage		=	critical,serverAuth,clientAuth,codeSigning,emailProtection,timeStamping,OCSPSigning,msCTLSign,msEFS

EOT

openssl req -x509 -new -key rootCA.key -sha256 -days 7300 -out rootCA.crt -config root.ext.cnf
openssl x509 -in rootCA.crt -text -noout
