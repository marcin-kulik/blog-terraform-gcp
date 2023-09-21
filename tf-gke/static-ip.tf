resource "google_compute_address" "wordpress_static_ip" {
  name   = "wordpress-static-ip"
  region = var.region
}