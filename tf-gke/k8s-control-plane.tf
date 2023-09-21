resource "google_container_cluster" "gke-control-plane" {
  name               = var.cluster_name
  location           = var.zone
  network            = google_compute_network.vpc-terraform.name
  subnetwork         = google_compute_subnetwork.subnet-europe-west2.name
  networking_mode    = "VPC_NATIVE"
  #  remove_default_node_pool = true - do i need it?

  min_master_version       = var.k8s_version
  initial_node_count = var.min_node_count

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.13.0.0/28"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.11.0.0/21"
    services_ipv4_cidr_block = "10.12.0.0/21"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "84.247.43.217/32"
      display_name = "authorised_ip_1"
    }
    cidr_blocks {
      cidr_block   = "84.247.43.225/32"
      display_name = "authorised_ip_2"
    }
    cidr_blocks {
      cidr_block   = "84.247.43.221/32"
      display_name = "authorised_ip_3"
    }
    cidr_blocks {
      cidr_block   = "84.247.43.223/32"
      display_name = "authorised_ip_4"
    }
    cidr_blocks {
      cidr_block   = "84.247.43.226/32"
      display_name = "authorised_ip_5"
    }
    cidr_blocks {
      cidr_block   = "84.247.43.224/32"
      display_name = "authorised_ip_6"
    }
    cidr_blocks {
      cidr_block   = "31.94.68.110/32"
      display_name = "authorised_ip_7"
    }
    cidr_blocks {
      cidr_block   = "84.247.41.229/32"
      display_name = "authorised_ip_8"
    }
    cidr_blocks {
      cidr_block   = "84.247.41.231/32"
      display_name = "authorised_ip_9"
    }
    cidr_blocks {
      cidr_block   = "84.247.41.238/32"
      display_name = "authorised_ip_10"
    }
    cidr_blocks {
      cidr_block   = "84.247.41.33/32"
      display_name = "authorised_ip_11"
    }
    cidr_blocks {
      cidr_block   = "84.247.41.175/32"
      display_name = "authorised_ip_12"
    }
  }
}
