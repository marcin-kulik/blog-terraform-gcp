resource "google_compute_firewall" "allow_http_inbound" {
  name    = "allow-http-inbound"
  network = google_compute_network.vpc-terraform.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_gke_master" {
  name    = "allow-gke-master"
  network = google_compute_network.vpc-terraform.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["31.94.23.218/32"]
}

resource "google_compute_firewall" "allow_all_outbound" {
  name    = "allow-all-outbound"
  network = google_compute_network.vpc-terraform.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/24"]
}

resource "random_string" "main" {
  length  = 16
  special = false
  upper   = false
}
