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