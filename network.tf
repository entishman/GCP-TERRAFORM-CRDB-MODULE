# -----------------------------------------------------------------------
# Create VPC, IGW, subnets (public and private),  route tables (public and private) and routes.
# -----------------------------------------------------------------------

resource "google_compute_network" "network1" {
  name                    = "gcp_trs_network"
  auto_create_subnetworks = false
  description             = "Network for GCP project"
}
