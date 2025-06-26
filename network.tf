resource "google_compute_network" "trs-network" {
  name                    = "trs-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "Network for GCP project with static internal IP address"
}
#-------------------------------------------------------------------------------------
resource "google_compute_subnetwork" "trs-public-subnetwork" {
  count         = 3
  name          = "trs-public-subnetwork-${count.index + 1}"
  region        = "us-west2"
  network       = google_compute_network.trs-network.id
  ip_cidr_range = local.public_subnet_list[count.index]
}
resource "google_compute_subnetwork" "trs-private-subnetwork" {
  count         = 3
  name          = "trs-private-subnetwork-${count.index + 1}"
  region        = "us-west2"
  network       = google_compute_network.trs-network.id
  ip_cidr_range = local.private_subnet_list[count.index]
}
#-------------------------------------------------------------------------------------
resource "google_compute_address" "trs-static-public-internal-ip" {
  count        = 3
  name         = "my-compute-public-static-internal-ip-${count.index + 1}"         # Name for the static internal IP address resource
  subnetwork   = google_compute_subnetwork.trs-public-subnetwork[count.index].name # Associate with the subnetwork
  address_type = "INTERNAL"                                                        # Specify that this is an internal IP
  region       = "us-west2"                                                        # Must be in the same region as the subnetwork
  description  = "Static internal IP for my public compute instances"
}
resource "google_compute_address" "trs-static-private-internal-ip" {
  count        = 3
  name         = "my-compute-private-static-internal-ip-${count.index + 1}"         # Name for the static internal IP address resource
  subnetwork   = google_compute_subnetwork.trs-private-subnetwork[count.index].name # Associate with the subnetwork
  address_type = "INTERNAL"                                                         # Specify that this is an internal IP
  region       = "us-west2"                                                         # Must be in the same region as the subnetwork
  description  = "Static internal IP for my compute instance"
}
#-------------------------------------------------------------------------------------
/*
resource "google_compute_route" "default-internet-route" {
  name             = "blah-my-default-internet-route"        # Name of the route
  dest_range       = "0.0.0.0/0"                             # Destination CIDR range (0.0.0.0/0 means all traffic)
  network          = google_compute_network.trs-network.name # Name of the VPC network
  next_hop_gateway = "projects/${google-compute-network.trs-network.project}/global/gateways/default-internet-gateway"
  priority         = 1000 # Priority of the route (lower is higher priority)
  description      = "Route to the internet via default gateway"
}
*/
