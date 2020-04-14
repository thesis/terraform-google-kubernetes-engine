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
 * configs.  We don't specify key/value pairs in config map defaults.
 * Instead, we define individual variables that represent a config
 * map key/value pair so that we can provide proper descriptions with
 * each configurable option.  See individual variable definitions for
 * descriptions and allowed values.
*/

/* gke_cluster configs are for the google managed GKE master.
 * List of gke_cluster configs:
 * -----------------
 * name
 * private_cluster
 * master_ipv4_cidr_block
 * subnet
 * daily_maintenance_window_start_time
 * network_policy_enabled
 * logging_service
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

  default = {
    oauth_scopes = "https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring"
  }
}

/* Config maps descriptor variables.
 * These are not used directly.  They exist as a reference for each
 * option in one of the aforementioned config maps. In module
 * configuration we use map key/value pairs.
*/

## gke_cluster{}
variable "master_ipv4_cidr_block" {
  description = "IP range for master.  Must not overlap GKE subnet primary/secondary ranges.  Must be a /28 netmask."
  type        = "string"
  default     = ""
}

variable "subnet" {
  description = "The subnet to build GKE in. Subnet generated in GKE module used."
  type        = "string"
  default     = ""
}

variable "daily_maintenance_window_start_time" {
  description = "Time window where daily maintenance operations can start."
  type        = "string"
  default     = ""
}

variable "network_policy_enabled" {
  description = "Whether or not the cluster can configure network policies."
  type        = "string"
  default     = ""
}

## gke_node_pool vars
variable "node_count" {
  description = "The number of nodes for the pool.  Nodes per zone."
  type        = "string"
  default     = ""
}

variable "image_type" {
  description = "Base image for nodes."
  type        = "string"
  default     = ""
}

variable "machine_type" {
  description = "Machine type for nodes."
  type        = "string"
  default     = ""
}

variable "disk_type" {
  description = "Disk type mounted to nodes. pd-hdd, pd-ssd"
  type        = "string"
  default     = ""
}

variable "disk_size_gb" {
  description = "Size for node disk."
  type        = "string"
  default     = ""
}

variable "oauth_scopes" {
  description = "Google APIs the GKE cluster has access to."
  type        = "list"
  default     = []
}

variable "tags" {
  description = "Network tags to apply to VMs.  This impacts routing and firewall rules."
  type        = "list"
  default     = []
}

variable "auto_repair" {
  description = "Uses Google managed health checks to assess state and do repair. Node is drained/termed/recreated."
  type        = "string"
  default     = ""
}

variable "auto_upgrade" {
  description = "Keeps nodes up to date with latest stable Kubernetes version.  Uses maintenance window."
  type        = "string"
  default     = ""
}

## gke_subnet vars
variable "primary_ip_cidr_range" {
  description = "The subnet's primary range."
  type        = "string"
  default     = ""
}

variable "services_secondary_range_name" {
  description = "Secondary IP range name for GKE services. Required for private GKE."
  type        = "string"
  default     = ""
}

variable "services_secondary_ip_cidr_range" {
  description = "Secondary CIDR range for services.  Required for private GKE."
  type        = "string"
  default     = ""
}

variable "cluster_secondary_range_name" {
  description = "Secondary IP range name for GKE cluster pods. Required for private GKE."
  type        = "string"
  default     = ""
}

variable "cluster_secondary_ip_cidr_range" {
  description = "Secondary CIDR range for cluster pods. Required for private GKE."
  type        = "string"
  default     = ""
}
