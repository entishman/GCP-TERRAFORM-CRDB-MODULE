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

resource "google_compute_route" "default_internet_route" {
  name             = "blah-my-default-internet-route"        # Name of the route
  dest_range       = "0.0.0.0/0"                             # Destination CIDR range (0.0.0.0/0 means all traffic)
  network          = google_compute_network.trs-network.name # Name of the VPC network
  next_hop_gateway = "projects/${google_compute_network.trs-network.project}/global/gateways/default-internet-gateway"
  priority         = 1000 # Priority of the route (lower is higher priority)
  description      = "Route to the internet via default gateway"
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
