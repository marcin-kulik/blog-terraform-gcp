resource "google_service_account" "cloudsql_proxy" {
  account_id   = "cloudsql-proxy"
  display_name = "cloudsql-proxy"
}

resource "google_project_iam_member" "cloudsql_client" {
  project = "terraform-infra-397515"
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloudsql_proxy.email}"
}

