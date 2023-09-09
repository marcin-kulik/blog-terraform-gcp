terraform {
  backend "gcs" {
    bucket     = "7a30c6c49c3666ed-bucket-tfstate"
    prefix     = "terraform/state"
    credentials = "/Users/marcin/tmp/keys/terraform-infra-397515-ad3558ce6eb3.json"
  }
}