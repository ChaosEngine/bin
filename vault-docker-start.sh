#!/bin/bash
#

OPENSSL=/usr/bin/openssl
DOCKER=/usr/bin/docker
SLEEP=/usr/bin/sleep
JQ=/usr/bin/jq
CURL=/usr/bin/curl

VHOME=/home/container/hashicorp-vault
KEYS_FILENAME="$VHOME/vault-cluster.json"
PORT=8200



$OPENSSL req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout "$VHOME/config/key.pem" -out "$VHOME/config/cert.pem" -config "$VHOME/myopenssl.cnf"
$OPENSSL x509 -in "$VHOME/config/cert.pem" -text -noout

$DOCKER run -d --rm --name vault \
	-p $PORT:$PORT \
	-v "$VHOME":/vault \
	hashicorp/vault server
$SLEEP 2
IP_ADDRESS="$($DOCKER inspect -f '{{.NetworkSettings.IPAddress}}' vault)"

$CURL -k --request POST --data '{ "key": "'$($JQ -r .keys_base64[0] < $KEYS_FILENAME)'" }' "https://$IP_ADDRESS:$PORT/v1/sys/unseal" | $JQ \
	&& $SLEEP 1 && \
$CURL -k --request POST --data '{ "key": "'$($JQ -r .keys_base64[1] < $KEYS_FILENAME)'" }' "https://$IP_ADDRESS:$PORT/v1/sys/unseal" | $JQ \
	&& $SLEEP 1 && \
$CURL -k --request POST --data '{ "key": "'$($JQ -r .keys_base64[2] < $KEYS_FILENAME)'" }' "https://$IP_ADDRESS:$PORT/v1/sys/unseal" | $JQ


$JQ -r .root_token < "$KEYS_FILENAME"
