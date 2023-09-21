resource "google_container_node_pool" "worker-nodes" {
  name       = google_container_cluster.gke-control-plane.name
  location   = var.zone
  cluster    = google_container_cluster.gke-control-plane.name
  node_count = var.min_node_count

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = "dev"
    }

    machine_type     = var.gke_machine_type
    preemptible      = var.preemptible
    image_type = var.image_type
    service_account  = google_service_account.gke-sa.email
    gke_disk_size_gb = var.gke_disk_size

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
  management {
    auto_upgrade = false
  }
  timeouts {
    create = "15m"
    update = "1h"
  }
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "USE_GKE_GCLOUD_AUTH_PLUGIN=True KUBECONFIG=$PWD/kubeconfig gcloud container clusters get-credentials ${var.cluster_name} --project ${google_project.main.project_id} --region ${var.region}"
  }
  depends_on = [
    google_container_cluster.gke-control-plane,
  ]
}

resource "null_resource" "destroy-kubeconfig" {
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f $PWD/kubeconfig $PWD/gke_gcloud_auth_plugin_cache"
  }
}

resource "null_resource" "ingress-nginx" {
  count = var.ingress_nginx == true ? 1 : 0
  provisioner "local-exec" {
    command = "KUBECONFIG=$PWD/kubeconfig kubectl apply --filename https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.0/deploy/static/provider/cloud/deploy.yaml"
  }
  depends_on = [
    null_resource.kubeconfig,
  ]
}

provider "helm" {
  kubernetes {
    config_path = "kubeconfig"
  }
}
