resource "google_compute_network" "vpc-terraform" {
  name                    = "terraform-infra-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-europe-west2" {
  name          = "terraform-infra-subnet-europe-west2"
  region        = "europe-west2"
  network       = google_compute_network.vpc-terraform.name
  ip_cidr_range = "10.0.0.0/24"
}

## Service Account
resource "google_service_account" "gke-sa" {
  account_id   = "gke-sa"
  display_name = "Service Account for GKE nodes"
}

## GKE cluster
resource "google_container_cluster" "gke-cluster" {
  name               = "gke-cluster"
  location           = "europe-west2-a"
  network            = google_compute_network.vpc-terraform.name
  subnetwork         = google_compute_subnetwork.subnet-europe-west2.name
  networking_mode    = "VPC_NATIVE"
  initial_node_count = 1

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.13.0.0/28"
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.11.0.0/21"
    services_ipv4_cidr_block = "10.12.0.0/21"
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.7/32"
      display_name = "authorised_ip"
    }
  }
}

## Create managed node pool
resource "google_container_node_pool" "gke-node-pool" {
  name       = google_container_cluster.gke-cluster.name
  location   = "europe-west2-a"
  cluster    = google_container_cluster.gke-cluster.name
  node_count = 2

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = "dev"
    }

    machine_type    = "g1-small"
    preemptible     = true
    service_account = google_service_account.gke-sa.email
    disk_size_gb    = 10

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

