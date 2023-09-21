resource "google_compute_network" "vpc-terraform" {
  name                    = var.network
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-europe-west2" {
  name          = var.subnetwork
  region        = var.region
  network       = google_compute_network.vpc-terraform.name
  ip_cidr_range = "10.0.0.0/24"
}