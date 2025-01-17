GENERATE_ECPRIVATE = openssl ecparam -name prime256v1 -genkey -noout -out


.PHONY: all
all: ca client server inet-dist-tls.config

%.key:
	$(GENERATE_ECPRIVATE) $@

ca.crt: openssl.conf ca.key
	openssl req -new -x509 -config openssl.conf -key ca.key -extensions "root_ca_extensions" -subj "/CN=TESTCA" -out ca.crt

.PHONY: ca
ca: ca.key ca.crt

server.csr: openssl.conf server.key
	openssl req -new -config openssl.conf -key server.key -subj "/CN=mas-util-devn/O=server" -out $@

server.crt: openssl.conf server.key server.csr ca.key ca.crt
	openssl req -config openssl.conf -CA ca.crt -CAkey ca.key \
		-extensions "server_extensions" -copy_extensions none -in server.csr -out server.crt

.PHONY: server
server: server.key server.csr server.crt

client.csr: openssl.conf client.key
	openssl req -new -config openssl.conf -key client.key -subj "/CN=mas-util-devn/O=client" -out $@

client.crt: openssl.conf client.csr ca.key ca.crt
	openssl req -config openssl.conf -CA ca.crt -CAkey ca.key \
		-extensions "client_extensions" -copy_extensions none -in client.csr -out $@

.PHONY: client
client: client.key client.csr client.crt

inet-dist-tls.config:
	m4 inet-dist-tls.config.m4 > inet-dist-tls.config

openssl.conf:
	m4 openssl.conf.m4 > openssl.conf

.PHONY: verify
verify: ca server client
	openssl verify -CAfile ca.crt server.crt client.crt

clean:
	rm -f ca.key ca.crt client.csr client.key client.crt server.csr server.key server.crt inet-dist-tls.config openssl.conf

