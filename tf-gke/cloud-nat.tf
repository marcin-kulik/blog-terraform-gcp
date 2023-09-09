# [START cloudnat_router_nat_gke]
resource "google_compute_router" "nat-router" {
  project = "terraform-infra-397515"
  name    = "nat-router"
  network = "terraform-infra-network"
  region  = "europe-west2"
}
# [END cloudnat_router_nat_gke]

# [START cloudnat_nat_gke]
module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 4.0"
  project_id                         = "terraform-infra-397515"
  region                             = "europe-west2"
  router                             = google_compute_router.nat-router.name
  name                               = "nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
# [END cloudnat_nat_gke]



### Jump host able to access GKE cluster, the ip of this jump host is already authorized to the GKE cluster
#resource "google_compute_address" "internal-ip-addr" {
#  project      = "terraform-infra-397515"
#  address_type = "INTERNAL"
#  region       = "europe-west2"
#  subnetwork   = "terraform-infra-subnet-europe-west2"
#  name         = "jump-host-ip"
#  address      = "10.0.0.7"
#  description  = "An internal IP address for the jump host"
#  depends_on = [google_compute_subnetwork.subnet-europe-west2]
#}
#
#resource "google_compute_instance" "jump-host-vm" {
#  project      = "terraform-infra-397515"
#  zone         = "europe-west2-a"
#  name         = "jump-host"
#  machine_type = "e2-micro"
#
#  boot_disk {
#    initialize_params {
#      image = "debian-cloud/debian-11"
#      size  = 10
#    }
#  }
#  network_interface {
#    network    = "terraform-infra-network"
#    subnetwork = "terraform-infra-subnet-europe-west2"
#    network_ip = google_compute_address.internal-ip-addr.address
#  }
#}
#
### Firewall to access jump host via IAP
#resource "google_compute_firewall" "firewall-rules" {
#  project = "terraform-infra-397515"
#  name    = "allow-ssh"
#  network = "terraform-infra-network"
#
#  allow {
#    protocol = "tcp"
#    ports    = ["22"]
#  }
#  source_ranges = ["35.235.240.0/20"]
#  depends_on = [google_compute_network.vpc-terraform]
#}
#
### IAP SSH permissions
#resource "google_project_iam_member" "ssh-permissions" {
#  project = "terraform-infra-397515"
#  role    = "roles/iap.tunnelResourceAccessor"
#  member  = "serviceAccount:infra-admin@terraform-infra-397515.iam.gserviceaccount.com"
#}
#
### Cloud router for nat gateway
#resource "google_compute_router" "router" {
#  project = "terraform-infra-397515"
#  name    = "nat-router"
#  network = "terraform-infra-network"
#  region  = "europe-west2"
#  depends_on = [google_compute_network.vpc-terraform]
#}
#
### Nat Gateway
#module "cloud-nat" {
#  source     = "terraform-google-modules/cloud-nat/google"
#  version    = "~> 1.2"
#  project_id = "terraform-infra-397515"
#  region     = "europe-west2"
#  router     = google_compute_router.router.name
#  name       = "cloud-nat"
#}
#
#
#
#
