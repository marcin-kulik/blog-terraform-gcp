output "kubernetes_cluster_host" {
  value       = google_container_cluster.gke-cluster.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.gke-cluster.name
  description = "GKE Cluster Name"
}

output "sql_user_name" {
  description = "The username for the SQL database."
  value       = google_sql_user.wordpress_user.name
}

output "sql_user_password" {
  description = "The password for the SQL database user."
  value       = random_password.wp_password.result
  sensitive   = true
}

output "service_account_email_cloudsql_proxy" {
  value = google_service_account.cloudsql_proxy.email
}

output "wordpress_static_ip_address" {
  description = "The static IP address reserved for WordPress"
  value       = google_compute_address.wordpress_static_ip.address
}