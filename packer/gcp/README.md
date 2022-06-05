# Precondition

```shell
gcloud iam service-accounts create packer \
  --project packer-352403 \
  --description="Packer Service Account" \
  --display-name="Packer Service Account"

gcloud projects add-iam-policy-binding packer-352403 \
    --member=serviceAccount:packer@packer-352403.iam.gserviceaccount.com \
    --role=roles/compute.instanceAdmin.v1

gcloud projects add-iam-policy-binding packer-352403 \
    --member=serviceAccount:packer@packer-352403.iam.gserviceaccount.com \
    --role=roles/iam.serviceAccountUser

gcloud projects add-iam-policy-binding packer-352403 \
    --member=serviceAccount:packer@packer-352403.iam.gserviceaccount.com \
    --role=roles/iap.tunnelResourceAccessor
```

# After Image Creation

```shell
gcloud compute instances create test \
  --project=packer-352403 \
  --image-family=packer-ubuntu-gcp \
  --image-project=packer-352403 \
  --network=default \
  --zone=asia-east2-a \
  --machine-type=n1-standard-2 \
  --service-account=packer@packer-352403.iam.gserviceaccount.com \
  --scopes="https://www.googleapis.com/auth/cloud-platform"
```
# Ubuntu install kubectl client
```shell
snap install kubectl --classic
```
# Start minikube
```shell
minikube start
kubectl proxy --address 0.0.0.0 --accept-hosts='^.*'
```
# Start minikube
- need setup firewall rule for allow ingress of my laptop external ip
