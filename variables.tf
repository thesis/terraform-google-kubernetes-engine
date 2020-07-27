# generic vars
variable "region" {
  description = "The region where resources are generated."
  type        = "string"
  default     = ""
}

variable "project" {
  description = "The project id of the project you want to create the bucket in."
  type        = "string"
  default     = ""
}

variable "vpc_network_name" {
  description = "Name of the vpc network to associate GKE cluster with."
  type        = "string"
  default     = ""
}

variable "labels" {
  description = "A list of key/value pairs to describe your resource.  Labels are akin to tags."
  type        = "map"
  default     = {}
}

/* Config maps: Containers to hold logical groupings of GKE
 * configs.  These groupings aren't required, but are to try
 * and help inform how the bits fit together.
*/

/* gke_cluster configs are for the google managed GKE master.
 * List of gke_cluster configs:
 * -----------------
 * name
 * subnet
 * daily_maintenance_window_start_time
 * network_policy_enabled
 * logging_service
 * enable_private_nodes
 * enable_private_endpoint
 * master_ipv4_cidr_block
*/

variable "gke_cluster" {
  description = ""
  type        = "map"
  default     = {}
}

/* gke_subnet configs are for the GKE subnet.
 * Must have services/cluster secondary ranges.
 * List of gke_subnet configs:
 * -----------------
 * name
 * primary_cidr_range
 * services_secondary_range_name
 * services_secondary_ip_cidr_range
 * cluster_secondary_range_name
 * cluster_secondary_ip_cidr_range
*/

variable "gke_subnet" {
  description = ""
  type        = ""
  default     = {}
}

/* gke_node_pool configs set size and compute resources for cluster nodes.
 * List of gke_node_pool configs:
 * -----------------
 * name
 * node_count
 * machine_type
 * disk_type
 * disk_size_gb
 * auto_repair
 * auto_upgrade
 * oauth_scopes
*/

variable "gke_node_pool" {
  description = ""
  type        = "map"

  default = {}
}
