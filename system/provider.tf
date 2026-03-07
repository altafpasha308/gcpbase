terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
provider "google" {
  credentials = file("/home/amit23comp/sa.json")  # Path to your GCP credentials file
  project     = "seraphic-lock-174915"                 # Your GCP project ID
  region      = "asia-south1-c"                        # Your desired region
}
