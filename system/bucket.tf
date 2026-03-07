resource "google_storage_bucket" "example" {
  name          = "amitow23test123" #change and provide unique name to the bucket
  location      = "US"
  force_destroy = true
}
