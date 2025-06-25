resource "google_compute_network" "trs-network" {
  name                    = "trs-network"
  auto_create_subnetworks = false
  description             = "Network for GCP project"
}

resource "google_compute_subnetwork" "trs-public-subnetwork" {
  count         = 3
  name          = "trs-public-subnetwork-${count.index}"
  region        = "us-west2"
  network       = google_compute_network.trs-network.id
  ip_cidr_range = local.public_subnet_list[count.index]
}

resource "google_compute_subnetwork" "trs-private-subnetwork" {
  count         = 3
  name          = "trs-private-subnetwork-${count.index}"
  region        = "us-west2"
  network       = google_compute_network.trs-network.id
  ip_cidr_range = local.private_subnet_list[count.index]
}
/*
resource "google_compute_address" "trs-address" {
  name         = "trs-address"
  region       = "us-west2"
  address_type = "INTERNAL"
  #network      = google_compute_network.trs-network.id
  subnetwork = google_compute_subnetwork.trs-private-subnetwork.id
}
*/
