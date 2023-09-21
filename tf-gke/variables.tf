variable "tf_version" {
  type = "string"
  default = "~> 4.0"
}

variable "credentials" {
  type = "key.json"
}

variable "project_id" {
  type    = string
  default = "terraform-gke"
}

variable "billing_account_id" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "zone" {
  type    = string
  default = "europe-west2-a"
}

variable "network" {
  type    = string
  default = "terraform-infra-network"
}

variable "subnetwork" {
  type    = string
  default = "terraform-infra-subnet-europe-west2"
}

# GKE
variable "cluster_name" {
  type    = string
  default = "gke-cluster"
}

variable "min_node_count" {
  type    = number
  default = 1
}

variable "max_node_count" {
  type    = number
  default = 3
}

variable "gke_machine_type" {
  type    = string
  default = "g1-small"
}

variable "image_type" {
  type    = string
  default = "cos_containerd"
}

variable "preemptible" {
  type    = bool
  default = true
}

variable "gke_disk_size" {
  type    = number
  default = 10
}

variable "k8s_version" {
  type = string
  default = "1.27"
}

variable "ingress_nginx" {
  type    = bool
  default = true
}

variable "dns_name" {
  type = string
  default = "kubernetix.co.uk."  # Ensure the trailing dot
}

variable "sql_tier" {
  type = string
  default = "db-f1-micro"
}