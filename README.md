
<!-- Module Name and description are required -->
# Google Kubenetes Engine

Provides a private regional GKE cluster in a dedicated subnet, with a
configurable node pool.

<!-- Compatibility section is optional -->
## Compatibility

This module is compatible with Terraform `<= 0.12.0`
And the Google Cloud Provider `<= 1.19.0`

<!-- Usage section is required -->
## Usage

<!-- NOTE: Examples should go into an `/examples` directory, with a link here
along the following lines:

There are multiple examples included in the [examples](./examples/) folder but
simple usage is as follows:
 -->

Simple module usage is as follows.

```hcl
locals {
  gke_subnet_name = "${var.environment}-${module.vpc.vpc_subnet_prefix}-gke-${var.region_data["region"]}"
}

module "your_custom_name_for_your_instance_of_this_module" {
  source           = "git@github.com:thesis/this-module-name.git"
  name             = "name-of-your-project"
  project          = "${module.project.project_id}"
  region           = "${var.region_data["region"]}"
  vpc_network_name = "${module.vpc.vpc_network_name}"

  gke_subnet {
    name                             = "${local.gke_subnet_name}"
    primary_ip_cidr_range            = "${var.gke_subnet["primary_ip_cidr_range"]}"
    services_secondary_range_name    = "${var.gke_subnet["services_secondary_range_name"]}"
    services_secondary_ip_cidr_range = "${var.gke_subnet["services_secondary_ip_cidr_range"]}"
    cluster_secondary_range_name     = "${var.gke_subnet["cluster_secondary_range_name"]}"
    cluster_secondary_ip_cidr_range  = "${var.gke_subnet["cluster_secondary_ip_cidr_range"]}"
  }

  gke_cluster {
    name                                = "${var.gke_cluster["name"]}"
    private_cluster                     = "${var.gke_cluster["private_cluster"]}"
    master_ipv4_cidr_block              = "${var.gke_cluster["master_ipv4_cidr_block"]}"
    daily_maintenance_window_start_time = "${var.gke_cluster["daily_maintenance_window_start_time"]}"
    network_policy_enabled              = "${var.gke_cluster["network_policy_enabled"]}"
    network_policy_provider             = "${var.gke_cluster["network_policy_provider"]}"
    logging_service                     = "${var.gke_cluster["logging_service"]}"
    monitoring_service                  = "${var.gke_cluster["monitoring_service"]}"
  }

  gke_node_pool {
    name         = "${var.gke_node_pool["name"]}"
    node_count   = "${var.gke_node_pool["node_count"]}"
    machine_type = "${var.gke_node_pool["machine_type"]}"
    disk_type    = "${var.gke_node_pool["disk_type"]}"
    disk_size_gb = "${var.gke_node_pool["disk_size_gb"]}"
    oauth_scopes = "${var.gke_node_pool["oauth_scopes"]}"
    auto_repair  = "${var.gke_node_pool["auto_repair"]}"
    auto_upgrade = "${var.gke_node_pool["auto_upgrade"]}"
    tags         = "${module.nat_gateway_zone_a.routing_tag_regional}"
  }

  labels = "${local.labels}"
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| auto\_repair | Uses Google managed health checks to assess state and do repair. Node is drained/termed/recreated. | string | `""` | no |
| auto\_upgrade | Keeps nodes up to date with latest stable Kubernetes version.  Uses maintenance window. | string | `""` | no |
| cluster\_secondary\_ip\_cidr\_range | Secondary CIDR range for cluster pods. Required for private GKE. | string | `""` | no |
| cluster\_secondary\_range\_name | Secondary IP range name for GKE cluster pods. Required for private GKE. | string | `""` | no |
| daily\_maintenance\_window\_start\_time | Time window where daily maintenance operations can start. | string | `""` | no |
| disk\_size\_gb | Size for node disk. | string | `""` | no |
| disk\_type | Disk type mounted to nodes. pd-hdd, pd-ssd | string | `""` | no |
| gke\_cluster |  | map | `<map>` | no |
| gke\_node\_pool |  | map | `<map>` | no |
| gke\_subnet |  | map | `<map>` | no |
| image\_type | Base image for nodes. | string | `""` | no |
| labels | A list of key/value pairs to describe your resource.  Labels are akin to tags. | map | `<map>` | no |
| machine\_type | Machine type for nodes. | string | `""` | no |
| master\_ipv4\_cidr\_block | IP range for master.  Must not overlap GKE subnet primary/secondary ranges.  Must be a /28 netmask. | string | `""` | no |
| network\_policy\_enabled | Whether or not the cluster can configure network policies. | string | `""` | no |
| node\_count | The number of nodes for the pool.  Nodes per zone. | string | `""` | no |
| oauth\_scopes | Google APIs the GKE cluster has access to. | list | `<list>` | no |
| primary\_ip\_cidr\_range | The subnet's primary range. | string | `""` | no |
| project | The project id of the project you want to create the bucket in. | string | `""` | no |
| region | The region where resources are generated. | string | `""` | no |
| services\_secondary\_ip\_cidr\_range | Secondary CIDR range for services.  Required for private GKE. | string | `""` | no |
| services\_secondary\_range\_name | Secondary IP range name for GKE services. Required for private GKE. | string | `""` | no |
| subnet | The subnet to build GKE in. Subnet generated in GKE module used. | string | `""` | no |
| tags | Network tags to apply to VMs.  This impacts routing and firewall rules. | list | `<list>` | no |
| vpc\_network\_name | Name of the vpc network to associate GKE cluster with. | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_ca\_certificate | Base64 encoded public certificate that is the root of trust for the cluster. |
| endpoint | The IP address of this cluster's Kubernetes master. |
| name | The name of the GKE cluster. |
| public\_endpoint | The IP address of this cluster's Kubernetes master. |
| vpc\_gke\_subnet\_name | The name of your created public subnet. |
| vpc\_gke\_subnet\_self\_link | The URI of the GKE subnet. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Notes section is optional -->
<!-- ## Notes

Anything quirky about the module folks may want to know about. Relevant
links or additional useful information.  Format is up to you.
 -->
<!-- License is required -->
## License

See [LICENSE](./LICENSE).
