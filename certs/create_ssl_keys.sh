#!/bin/bash

# =============================================================================
# ssl-certs.sh - Self signing SSL certificates
#
# Author: Steve Shreeve <steve.shreeve@gmail.com>
#   Date: Dec 17, 2022
# =============================================================================

# Use https://gist.github.com/shreeve/3358901a26a21d4ddee0e1342be7749d
# See https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309

# variables
name="Cloud Hunters Inc."
base="cloudhunters.io"
root="ca"
myip="$(ifconfig | awk '/inet / { print $2 }' | grep -v -E "^172\." | head -1)"

# create root key and certificate
openssl genrsa -out "${root}.key" 3072
openssl req -x509 -nodes -sha256 -new -key "${root}.key" -out "${root}.crt" -days 731 \
  -subj "/CN=Custom Root" \
  -addext "keyUsage = critical, keyCertSign" \
  -addext "basicConstraints = critical, CA:TRUE, pathlen:0" \
  -addext "subjectKeyIdentifier = hash"

# create our key and certificate signing request
openssl genrsa -out "${base}.key" 2048
openssl req -sha256 -new -key "${base}.key" -out "${base}.csr" \
  -subj "/CN=*.${base}/O=${name}/OU=$(whoami)@$(hostname)" \
  -reqexts SAN -config <(echo "[SAN]\nsubjectAltName=DNS:${base},DNS:*.${base},IP:127.0.0.1,IP:${myip}\n")

# create our final certificate and sign it
openssl x509 -req -sha256 -in "${base}.csr" -out "${base}.crt" -days 731 \
  -CAkey "${root}.key" -CA "${root}.crt" -CAcreateserial -extfile <(cat <<END
    subjectAltName = DNS:${base},DNS:*.${base},IP:127.0.0.1,IP:${myip}
    keyUsage = critical, digitalSignature, keyEncipherment
    extendedKeyUsage = serverAuth
    basicConstraints = CA:FALSE
    authorityKeyIdentifier = keyid:always
    subjectKeyIdentifier = none
END
)

# Added by SWJ (uid0) -and DCODev1702 - 2023-12-14
mkdir -p ../config/ssl
mkdir -p ../config/trusted-certs

cp "${root}.crt" ../config/trusted-certs/"${root}.crt"
cp "${base}".crt ../config/ssl/"${myip}.crt"
cat "${root}.crt" >> ../config/ssl/"${myip}.crt"
cp ../config/ssl/"${myip}.crt" ../config/trusted-certs/"${myip}.crt"
cp "${base}.key" ../config/ssl/"${myip}.key"

