#!/bin/bash

echo "Generating TSIG key..."

tsig-keygen -a hmac-sha256 cert-manager-key

echo ""
echo " Copy the 'secret' value into:"
echo "   - bind named.conf"
echo "   - Kubernetes secret"