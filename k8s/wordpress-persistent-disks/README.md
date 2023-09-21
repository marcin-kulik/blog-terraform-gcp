# Using Persistent Disks with WordPress and MySQL

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/GoogleCloudPlatform/kubernetes-engine-samples&cloudshell_tutorial=README.md&cloudshell_workspace=wordpress-persistent-disks/)

Follow this tutorial at https://cloud.google.com/kubernetes-engine/docs/tutorials/persistent-disk/


# Setting up HTTPS

### Install cert on GKE

```shell
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.4.0/cert-manager.yaml
```

### Add 

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: marcin@kubernetes-unleashed.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
      - http01:
          ingress:
            class: nginx  # or whichever ingress class you're using
```

```shell
kubectl apply -f wordpress-letsencrypt-clusterissuer.yaml
```

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: wordpress-cert
  namespace: default
spec:
  secretName: wordpress-tls  # The secret where the cert will be stored
  issuerRef:
    name: letsencrypt-prod  # Refers to your ClusterIssuer
    kind: ClusterIssuer
  commonName: kubernetes-unleashed.com
  dnsNames:
  - kubernetes-unleashed.com
  - www.kubernetes-unleashed.com
```

```yaml
helm install nginx-ingress ingress-nginx/ingress-nginx \
--namespace ingress-nginx \
--create-namespace \
--set controller.service.loadBalancerIP=34.142.46.91
```




## does kubernetes-unleashed.com point to correct ip address
```shell
nslookup kubernetes-unleashed.com
```
