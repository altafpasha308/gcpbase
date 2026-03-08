output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.main-vpc.id
}

output "vpc_name" {
  description = "The Name tag of the VPC"
  # The "Name" tag value can be accessed via the tags attribute
  value       = google_compute_network.main-vpc.name
}

output "subnet_ids" {
  description = "List of IDs of all subnets"
  value       = google_compute_subnetwork.subnet-1.id
}

output "subnet_names" {
  description = "List of Names of all subnets"
  value       = google_compute_subnetwork.subnet-1.name
}

