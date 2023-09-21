# [START cloudnat_router_nat_gke]
resource "google_compute_router" "nat-router" {
  project = var.project_id + "${random_string.main.result}"
  name    = "nat-router"
  network = var.network
  region  = var.region
}
# [END cloudnat_router_nat_gke]

# [START cloudnat_nat_gke]
module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = var.tf_version
  project_id                         = var.project_id + "${random_string.main.result}"
  region                             = var.region
  router                             = google_compute_router.nat-router.name
  name                               = "nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}