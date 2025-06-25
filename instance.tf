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
