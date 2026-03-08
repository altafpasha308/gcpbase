terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
provider "google" {
  credentials = file("/home/altafpasha308/booming-landing-489605-j3-37042cde3484.json") # Path to your GCP credentials file
  project     = "booming-landing-489605-j3"                                             # Your GCP project ID
  region      = "australia-southeast1"                                                  # Your desired region
}
