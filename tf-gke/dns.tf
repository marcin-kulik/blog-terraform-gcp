resource "google_dns_managed_zone" "my_zone" {
  name        = "my-domain-zone"
  dns_name    = var.dns_name
  description = "My domain DNS zone"
}

resource "google_dns_record_set" "wordpress_a_record" {
  name         = var.dns_name
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.my_zone.name

  rrdatas = [google_compute_address.wordpress_static_ip.address]
}

resource "google_dns_record_set" "wordpress_a_record_www" {
  name         = var.dns_name
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.my_zone.name

  rrdatas = [google_compute_address.wordpress_static_ip.address]
}