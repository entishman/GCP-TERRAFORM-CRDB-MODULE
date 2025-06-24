output "subnetwork_listsssssss" {
  value = [
    for i in range(length(local.subnet_list)) : "${i}: ${local.subnet_list[i]}"
  ]
  description = "List of subnets created in the VPC"
}

output "Available_zone_list" {
  value = [
    for i in range(length(local.availability_zone_list)) : "${i}: ${local.availability_zone_list[i]}"
  ]
  description = "List of availability zones"
}

/*
output "image_range_size_images" {
  value = length(data.google_compute_images.gcp_public_images.images)
}

output "ListOfAllZones" {
  value       = data.google_compute_zones.available_azs
  description = "A list of all zones"
}

output "ListOfAllZonesbyForLoop" {
  value = [for zone in data.google_compute_zones.available_azs.names : zone]
}

output "ListOfAllZonesbyIndex_i" {
  value = [
    for i in range(length(data.google_compute_zones.available_azs.names)) : "${i}: ${data.google_compute_zones.available_azs.names[i]}"
  ]
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


