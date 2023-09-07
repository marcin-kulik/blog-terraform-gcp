terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.8.0"
    }
  }
}

provider "google" {
  project     = "terraform-infra-397515"
  region      = "europe-west2-a"
  credentials = file("/Users/marcin/tmp/keys/terraform-infra-397515-ad3558ce6eb3.json")
  zone        = "europe-west2"
}