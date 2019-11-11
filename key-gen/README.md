# KEY-GEN in GITHUB's Action

generate a Certificate based on given intermidate CA. Generating certificate can be done by using openssl, here's an example of that

Create a key, keep this key private and don't upload it anywhere

```
openssl genrsa -out RootCA.key 1024
openssl req -new -x509 -days 10000 -key RootCA.key -out RootCA.crt -subj /C=CA/ST=Ontario/O=CompanyName/CN=root
```

Generate Intermidate CA, this key can be upload to Github Secrets. Make sure to put small validation days

```
openssl genrsa -out IntermediateCA.key 1024
openssl req -new -key IntermediateCA.key -out IntermediateCA.csr -subj /C=CA/ST=ONTARIO/O=AwesomeProject/CN=intermediate
openssl x509 -req -days 100 -in IntermediateCA.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial -CAserial serial -out IntermediateCA.crt -sha256
openssl rsa -in IntermediateCA.key -pubout -out IntermediateCA.pub
```

Once the action is performed, the newly generated keys will be store in `/github/home/certs/`:

```
/github/home/certs/$CERT_NAME.key
/github/home/certs/$CERT_NAME.csr
/github/home/certs/$CERT_NAME.crt
```

## USAGE

```yml
- name: Create Deployment Cert keys
  uses: alinz/actions/key-gen@master
  env:
    CERT_NAME: service1
    CERT_KEY_SIZE: 1024
    CERT_COUNTRY_NAME: CA
    CERT_STATE_NAME: Ontario
    CERT_PROJECT_NAME: AwesomePrject
    SUBJECT_ALT_NAME: IP:127.0.0.1,DNS:localhost
    INTERMEDIATE_KEY: ${{ secrets.INTERMEDIATE_KEY }}
    INTERMEDIATE_CA: ${{ secrets.INTERMEDIATE_CA }}
```
