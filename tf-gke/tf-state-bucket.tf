# [START storage_kms_encryption_tfstate]
resource "google_kms_key_ring" "terraform_state" {
  name     = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  location = var.region
}

resource "google_kms_crypto_key" "terraform_state_bucket" {
  name            = "test-terraform-state-bucket"
  key_ring        = google_kms_key_ring.terraform_state.id
  rotation_period = "86400s"

  lifecycle {
    prevent_destroy = false
  }
}

# [END storage_kms_encryption_tfstate]

# [START storage_bucket_tf_with_versioning]
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "terrafrom-state" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = var.region
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform_state_bucket.id
  }
  depends_on = [
    google_project_iam_member.kms
  ]
}