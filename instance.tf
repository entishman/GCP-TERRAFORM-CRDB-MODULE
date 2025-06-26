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

resource "google_compute_instance" "trs-public-instance" {
  count        = 3
  name         = "trs-compute-instance-${count.index}"
  machine_type = "e2-medium"
  zone         = data.google_compute_zones.available_zones[count.index].names

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.trs-network.name
    subnetwork = google_compute_subnetwork.trs-public-subnetwork[count.index].name
    network_ip = google_compute_address.trs-static-public-internal-ip[count.index].address
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "your-ssh-public-key"
  }
}
