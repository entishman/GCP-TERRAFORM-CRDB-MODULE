variable "gcp_region_01" {
  description = "The GCP region for the first set of resources"
  type        = string
  default     = "us-west2"
}

variable "gcp_zone_01" {
  description = "The GCP zone for the first set of resources"
  type        = string
  default     = "us-west2-a"
}

variable "my_ip_address" {
  description = "my IP address for accessing GCP compute instances"
  type        = string
  default     = "0.0.0.0"
}

variable "owner" {
  description = "The owner of the project"
  type        = string
  default     = "trs--"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = ""
}

variable "crdb_nodes" {
  description = "Number of crdb nodes.  This should be a multiple of 3.  Each node is an GCP Compute Instance"
  type        = number
  default     = 3
  validation {
    condition     = var.crdb_nodes % 3 == 0
    error_message = "The variable 'crdb_nodes' must be a multiple of 3"
  }
}
variable "crdb_store_volume_type" {
  description = "EBS Root Volume Type"
  type        = string
  default     = "gp2"
  validation {
    condition     = contains(["gp2", "gp3"], var.crdb_store_volume_type)
    error_message = "Valid values for variable crdb_root_volume_type is one of the following: 'gp2', 'gp3'"
  }
}

variable "crdb_store_volume_size" {
  description = "EBS Root Volume Size"
  type        = number
  default     = 8
}

variable "crdb_version" {
  description = "CockroachDB Version"
  type        = string
  default     = "24.2.4"
}

variable "crdb_arm_release" {
  description = "Do you want to use the ARM version of CRDB?  There are implications on the instances available for the installation.  You must choose the correct instance type or this will fail."
  type        = string
  default     = "yes"
  validation {
    condition     = contains(["yes", "no"], var.crdb_arm_release)
    error_message = "Valid value for variable 'arm' is : 'yes' or 'no'"
  }
}

variable "include_ha_proxy" {
  description = "'yes' or 'no' to include an HAProxy Instance"
  type        = string
  default     = "yes"
  validation {
    condition     = contains(["yes", "no"], var.include_ha_proxy)
    error_message = "Valid value for variable 'include_ha_proxy' is : 'yes' or 'no'"
  }
}

variable "include_app" {
  description = "'yes' or 'no' to include an HAProxy Instance"
  type        = string
  default     = "yes"
  validation {
    condition     = contains(["yes", "no"], var.include_app)
    error_message = "Valid value for variable 'include_app' is : 'yes' or 'no'"
  }
}

variable "app_instance_type" {
  description = "App Instance Type"
  type        = string
  default     = "t3a.micro"
}

variable "create_admin_user" {
  description = "'yes' or 'no' to create an admin user in the database.  This might only makes sense when adding an app instance since the certs will be created and configured automatically for connection to the database."
  type        = string
  default     = "yes"
  validation {
    condition     = contains(["yes", "no"], var.create_admin_user)
    error_message = "Valid value for variable 'include_ha_proxy' is : 'yes' or 'no'"
  }
}

variable "admin_user_name" {
  description = "An admin with this username will be created if 'create_admin_user=yes'"
  type        = string
  default     = ""
}

variable "resource_tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}


