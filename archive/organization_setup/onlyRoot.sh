#!/bin/bash
set -e

openssl genrsa -aes256 -out 'data/rootCA.key' 8192

cat <<EOT >'data/root.ext.cnf'
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
OU				=	arpanrec web authority
emailAddress	=	me@arpanrec.com
CN				=	arpanrec ROOT CA V1

[ v3_ca ]
subjectKeyIdentifier	=	hash
authorityKeyIdentifier	=	keyid,issuer
basicConstraints		=	critical,CA:TRUE
keyUsage				=	critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyCertSign,cRLSign
extendedKeyUsage		=	critical,serverAuth,clientAuth,codeSigning,emailProtection,timeStamping,OCSPSigning,msCTLSign,msEFS

EOT

openssl req -x509 -new -key 'data/rootCA.key' \
    -sha256 -days 7300 -out 'data/rootCA.crt' \
    -config 'data/root.ext.cnf'

openssl x509 -in 'data/rootCA.crt' -text -noout

rm -rf 'data/root.ext.cnf'
