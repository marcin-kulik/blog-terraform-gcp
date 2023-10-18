This project is a WordPress run on GKE with the use of Terraform.

To run this project a GCP account is needed with enabled billing account.


Login in terminal:

```shell
gcloud auth login
```

Create project and verify if it is created:

```shell
export PROJECT_ID=wordpress-tf-gke-$(date +%Y%m%d%H%M)
gcloud projects create $PROJECT_ID
gcloud projects list
```

Create necessary credentials:

```shell
gcloud iam service-accounts \
create wordpress-tf \
--project $PROJECT_ID \
--display-name wordpress-tf

gcloud iam service-accounts list \
    --project $PROJECT_ID
    
gcloud iam service-accounts \
    keys create account.json \
    --iam-account wordpress-tf@$PROJECT_ID.iam.gserviceaccount.com \
    --project $PROJECT_ID    

gcloud iam service-accounts \
    keys list \
    --iam-account wordpress-tf@$PROJECT_ID.iam.gserviceaccount.com \
    --project $PROJECT_ID
    
gcloud projects \
    add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:wordpress-tf@$PROJECT_ID.iam.gserviceaccount.com \
    --role roles/owner
    
export TF_VAR_project_id=$PROJECT_ID    
```