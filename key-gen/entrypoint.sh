#!/bin/sh

set -e

# All certificates will be store in github share disk
CERT_PATH=/github/home/certs

mkdir -p $CERT_PATH

echo $INTERMEDIATE_KEY > $CERT_PATH/IntermediateCA.key
echo $INTERMEDIATE_CA > $CERT_PATH/IntermediateCA.crt

openssl genrsa -out $CERT_PATH/$CERT_NAME.key $CERT_KEY_SIZE
openssl req -new -key $CERT_PATH/$CERT_NAME.key -out $CERT_PATH/$CERT_NAME.csr -subj /C=$CERT_COUNTRY_NAME/ST=$CERT_STATE_NAME/O=$CERT_PROJECT_NAME/CN=$CERT_NAME
openssl x509 -req -days $CERT_VALID_FOR -in $CERT_PATH/$CERT_NAME.csr -CA $CERT_PATH/IntermediateCA.crt -CAkey $CERT_PATH/IntermediateCA.key -CAcreateserial -out $CERT_PATH/$CERT_NAME.crt -sha256 -extfile <(echo subjectAltName=$SUBJECT_ALT_NAME)

mv $CERT_PATH/IntermediateCA.crt $CERT_PATH/ca.crt
rm $CERT_PATH/IntermediateCA.key

# encryption using aes-256 if ENCRYPT_KEY presented
if [ -v $ENCRYPT_KEY ]; then
  openssl aes-256-cbc -in $CERT_PATH/$CERT_NAME.key -out $CERT_PATH/$CERT_NAME.key.enc -k $ENCRYPT_KEY
fi