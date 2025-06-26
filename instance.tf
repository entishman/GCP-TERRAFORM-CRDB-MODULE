resource "google_compute_firewall" "allow_ssh" {
  name        = "allow-ssh-to-static-ip-resource-compute"
  network     = google_compute_network.trs-network.name # Apply to the custom VPC network
  description = "Allows SSH access (port 22) from anywhere to instances."

  allow {
    protocol = "tcp"
    ports    = ["22"] # Allow SSH port
  }

  source_ranges = ["0.0.0.0/0"] # Allow from any IP address
}

resource "google_compute_instance" "trs-vm-instance" {
  count        = 3
  name         = "instance-name-${count.index}"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.trs-network.name
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "your-ssh-public-key"
  }
}
