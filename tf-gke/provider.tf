terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.51"
    }
  }
}

provider "google" {
  project     = var.project_id + random_string.main.result
  region      = var.region
  credentials = file("key.json")
  zone        = var.zone
}