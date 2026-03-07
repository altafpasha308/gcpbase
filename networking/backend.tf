terraform {
  backend "gcs" {
    credentials = "/home/amit23comp/sa.json"
    bucket  = "amitow23test123"
    prefix  = "student.01-network-state"
  }
}
