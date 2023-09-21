terraform {
  backend "gcs" {
    bucket     = "7a30c6c49c3666ed-bucket-tfstate"
    prefix     = "terraform/state"
    credentials = "key.json"
  }
}