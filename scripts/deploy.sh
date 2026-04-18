#!/bin/bash

echo "Deploying ACME lab"

kubectl apply -f manifests/acme-rfc8555-lab.yaml

echo "Completed."