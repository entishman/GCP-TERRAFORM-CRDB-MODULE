resource "google_compute_network" "trs-network" {
  name                    = "trs-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "Network for GCP project with static internal IP address"
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
resource "google_compute_address" "trs-static_internal_ip" {
  name         = "my-compute-static-internal-ip"                           # Name for the static internal IP address resource
  subnetwork   = google_compute_subnetwork.trs-public-subnetwork.self_link # Associate with the subnetwork
  address_type = "INTERNAL"                                                # Specify that this is an internal IP
  address      = "10.0.0.1"                                                # The specific internal IP address to reserve
  region       = "us-west2"                                                # Must be in the same region as the subnetwork
  description  = "Static internal IP for my compute instance"
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
