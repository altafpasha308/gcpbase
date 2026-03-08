resource "google_storage_bucket" "example" {
  name          = "altafgcpbuckettest135" #change and provide unique name to the bucket
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
}
