#!/bin/bash

echo "Generating self-signed cert for Pebble"

openssl req -x509 -newkey rsa:2048 -nodes \
  -keyout pebble.key -out pebble.crt \
  -days 365 -subj "/CN=pebble"

echo "Generated:"
echo " - pebble.crt"
echo " - pebble.key"