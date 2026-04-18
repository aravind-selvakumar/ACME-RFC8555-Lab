# ACME RFC8555 Lab (Kubernetes)

<img width="622" height="678" alt="image" src="https://github.com/user-attachments/assets/b6812ef4-558c-489d-8c7e-b052de5df610" />

A self-contained lab to test ACME protocol flows using:

* Pebble (ACME test CA)
* Bind9 (DNS with RFC2136 dynamic updates)
* cert-manager (DNS-01 challenge automation)

This setup is designed for local environments (Minikube, kind, WSL) and enables full DNS-01 certificate issuance without external dependencies.

---

## Architecture

cert-manager → RFC2136 → Bind9 DNS → TXT Record → Pebble → Certificate Issued

---

## Prerequisites

* Kubernetes cluster (Minikube / kind / etc.)
* kubectl
* cert-manager installed

---

## Step 1: Generate Secrets

### Generate TSIG Key

```bash
./scripts/generate-tsig.sh
```

Update the following in `manifests/acme-rfc8555-lab.yaml`:

```
secret "REPLACE_WITH_TSIG_SECRET";
```

---

### Generate Pebble TLS Certificate

```bash
./scripts/generate-pebble-cert.sh
```

---

### Create Kubernetes Secrets

```bash
kubectl create secret generic pebble-cert \
  --from-file=pebble.crt \
  --from-file=pebble.key

kubectl create secret generic rfc2136-tsig-secret \
  --from-literal=secret=<BASE64_TSIG_SECRET>
```

---

## Step 2: Deploy Lab

```bash
kubectl apply -f manifests/acme-rfc8555-lab.yaml
```

---

## Step 3: Create Certificate

```bash
kubectl apply -f examples/certificate.yaml
```

---

## Verify

```bash
kubectl get certificates
kubectl get challenges -A
kubectl get secret test-cert-secret
```

---

## Notes

* Uses `.local` domain (safe for lab)
* `skipTLSVerify` enabled for Pebble
* RFC2136 used for DNS updates
* No external DNS required

---

## Cleanup

```bash
kubectl delete -f manifests/acme-rfc8555-lab.yaml
kubectl delete secret pebble-cert rfc2136-tsig-secret
```

---

## Future Enhancements

* Ingress + HTTPS demo app
* Replace Bind9 with cloud DNS (Route53, Azure DNS)
* CI pipeline validation

---
