resource "google_service_account" "cloudsql_proxy" {
  account_id   = "cloudsql-proxy"
  display_name = "cloudsql-proxy"
}

resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id + random_string.main.result
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloudsql_proxy.email}"
}

resource "google_service_account" "gke-sa" {
  account_id   = "gke-sa"
  display_name = "Service Account for GKE nodes"
}

resource "google_project_iam_member" "kms" {
  project = var.project_id
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:service-1090872326188@gs-project-accounts.iam.gserviceaccount.com"
}