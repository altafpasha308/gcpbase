resource "google_compute_network" "main-vpc" {
  name                    = "altaf-01-vpc"       # Name of the VPC
  auto_create_subnetworks = false                # Set to false for custom subnets
  description             = "Main VPC for Altaf" # Optional description
}

resource "google_compute_subnetwork" "subnet-1" {
  name                     = "altaf-subnet-1"                   # Name of the subnet
  ip_cidr_range            = "10.0.0.0/24"                      # Subnet CIDR range
  region                   = "australia-southeast1"             # Region for the subnet
  network                  = google_compute_network.main-vpc.id # Reference to the VPC
  description              = "Subnet 1 for Altaf"
  private_ip_google_access = true # Enable private Google access
}

resource "google_compute_router" "main-router" {
  name    = "altaf-router"
  region  = "australia-southeast1"
  network = google_compute_network.main-vpc.id
}

resource "google_compute_router_nat" "main-nat" {
  name                               = "altaf-nat"
  region                             = "australia-southeast1"
  router                             = google_compute_router.main-router.name
  nat_ip_allocate_option             = "AUTO_ONLY" # Automatically allocate NAT IP
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
