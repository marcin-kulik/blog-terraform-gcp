output "kubernetes_cluster_host" {
  value       = google_container_cluster.gke-cluster.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.gke-cluster.name
  description = "GKE Cluster Name"
}
