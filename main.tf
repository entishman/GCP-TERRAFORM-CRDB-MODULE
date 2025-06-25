provider "google" {
  project = "trs-proj1"
  region  = var.gcp_region_01
  zone    = var.gcp_zone_01
}

provider "cockroach" {
  # Configuration options
}

data "google_compute_zones" "available_azs" {
}

data "google_compute_images" "gcp_public_images" {
  # Common public image projects:
  # debian-cloud: Debian images
  # ubuntu-os-cloud: Ubuntu images
  filter  = "status:READY" # Only show images that are ready to be used
  project = "ubuntu-os-cloud"
}

locals {
  required_tags = {
    "owner"        = var.owner
    "project_name" = var.project_name
  }
  tags                    = merge(var.resource_tags, local.required_tags)
  cidr_newbit             = 3
  subnet_list             = cidrsubnets(var.vpc_cidr, local.cidr_newbit, local.cidr_newbit, local.cidr_newbit, local.cidr_newbit, local.cidr_newbit, local.cidr_newbit)
  private_subnet_list     = chunklist(local.subnet_list, 3)[0]
  public_subnet_list      = chunklist(local.subnet_list, 3)[1]
  availability_zone_count = 3
  availability_zone_list  = slice(data.google_compute_zones.available_azs.names, 0, local.availability_zone_count)
}

locals {
  sumtin = ["aaaa", "bbbb", "cccc"]
}
