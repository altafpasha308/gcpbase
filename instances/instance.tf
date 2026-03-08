data "terraform_remote_state" "network_details" {
  backend = "gcs"
  config = {
    bucket = "altafgcpbuckettest135" # GCS bucket name
    prefix = "networkingstate"       # Path to the remote state file
  }
}

resource "google_compute_instance" "my_vm" {
  name         = "altaf-instance"
  machine_type = "e2-micro"
  zone         = "australia-southeast1-a"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/4751156868206452390"
    }
  }

  network_interface {
    network    = data.terraform_remote_state.network_details.outputs.vpc_name
    subnetwork = data.terraform_remote_state.network_details.outputs.subnet_names
    access_config {}
  }

  tags = ["altaf-instance"]
}

output "instance_public_ip" {
  value       = google_compute_instance.my_vm.network_interface[0].access_config[0].nat_ip
  description = "The public IP address of the instance"
}
