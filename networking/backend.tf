terraform {
  backend "gcs" {
    credentials = "/home/altafpasha308/booming-landing-489605-j3-37042cde3484.json"
    bucket      = "altafgcpbuckettest135"
    prefix      = "networkingstate"
  }
}
