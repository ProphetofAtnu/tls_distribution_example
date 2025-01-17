[ req ]
encrypt_key = no

[ root_ca_extensions ]
basicConstraints = critical,CA:true
keyUsage = keyCertSign, cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer

[ client_extensions ]
basicConstraints = CA:false
keyUsage = digitalSignature,keyEncipherment
extendedKeyUsage = clientAuth
subjectAltName = DNS:localhost,DNS:syscmd(echo -n $(hostname)),IP:127.0.0.1

[ server_extensions ] 
basicConstraints = CA:false
keyUsage = digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid
subjectAltName = DNS:localhost,DNS:syscmd(echo -n $(hostname)),IP:127.0.0.1
