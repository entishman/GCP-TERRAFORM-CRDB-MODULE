output "The_grand_subnetwork_list" {
  value = [
    for i in range(length(local.subnet_list)) : "${i}: ${local.subnet_list[i]}"
  ]
  description = "List of subnets created in the VPC"
}

output "privateSubnetList" {
  value = [
    for i in range(length(local.private_subnet_list)) : "${i}: ${local.private_subnet_list[i]}"
  ]
  description = "List of private subnets created in the VPC"
}
output "publicSubnetList" {
  value = [
    for i in range(length(local.public_subnet_list)) : "${i}: ${local.public_subnet_list[i]}"
  ]
  description = "List of public subnets created in the VPC"
}
#-------------------------------------------------------------------------------------
output "ListOfAllZones" {
  value       = data.google_compute_zones.names
  description = "A list of all zones"
}

output "ListOfAllZonesbyForLoop" {
  value = [for zone in data.google_compute_zones.available_zones.names : zone]
}

output "ListOfAllZonesbyIndex_i" {
  value = [
    for i in range(length(data.google_compute_zones.available_zones.names)) : "${i}: ${data.google_compute_zones.available_zones.names[i]}"
  ]
}
#-------------------------------------------------------------------------------------
output "public_internal_IP_address" {
  value = [for i in range(length(google_compute_address.trs-static-public-internal-ip)) : "${i}: ${google_compute_address.trs-static-public-internal-ip[i].address}"]
}
output "public_internal_name" {
  value = [for i in range(length(google_compute_address.trs-static-public-internal-ip)) : "${i}: ${google_compute_address.trs-static-public-internal-ip[i].name}"]
}
output "private_internal_IP_address" {
  value = [for i in range(length(google_compute_address.trs-static-private-internal-ip)) : "${i}: ${google_compute_address.trs-static-private-internal-ip[i].address}"]
}
output "private_internal_name" {
  value = [for i in range(length(google_compute_address.trs-static-private-internal-ip)) : "${i}: ${google_compute_address.trs-static-private-internal-ip[i].name}"]
}
#-------------------------------------------------------------------------------------
output "List_of_public_compute_instances" {
  value = [for i in range(length(google_compute_instance.trs-public-instance)) : "${i}: ${google_compute_instance.trs-public-instance[i].name}"]
}
/*
output "image_range_size_images" {
  value = length(data.google_compute_images.gcp_public_images.images)
}


output "ListOfAllImages_by_index" {
  value = [
    for i in range(length(data.google_compute_images.gcp_public_images.images)) : "${i}: ${data.google_compute_images.gcp_public_images.images[i].name}"
  ]
}

output "My_IP_Address" {
  value = var.my_ip_address
}

output "ListOfAllZonesbyIndex1" {
  value = [
    for idx, zone in data.google_compute_zones.available_azs.names : {
      index = idx
      name  = zone
    }
  ]
}
*/


