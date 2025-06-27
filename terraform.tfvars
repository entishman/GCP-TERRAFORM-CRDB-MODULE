# changed:
my_ip_address = "24.69.84.116"
# changed:
#aws_region_01 = "us-west-2"
owner        = "trs--"
project_name = "trs-project"
# changed:
crdb_instance_key_name = "TRS-uswest2"
vpc_cidr               = "10.0.0.0/24"

# -----------------------------------------
# CRDB Specifications
# -----------------------------------------
crdb_nodes = 3
#crdb_instance_type         = "t4g.medium"
#crdb_store_volume_type     = "gp3"
crdb_store_volume_size = 100
crdb_version           = "24.2.4"
crdb_arm_release       = "yes"
#crdb_enable_spot_instances = "no"

# HA Proxyf
include_ha_proxy = "yes"
#haproxy_instance_type = "t3a.micro"

# APP Node
include_app       = "yes"
app_instance_type = "t3a.micro"

create_admin_user = "yes"
# changed:
admin_user_name = "tim"

