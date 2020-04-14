
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

Module usage is as follows:

```hcl
locals {
  gke_subnet_name = "name-of-your-subnet"
}

module "your_custom_name_for_your_instance_of_this_module" {
  source           = "git@github.com:thesis/this-module-name.git"
  name             = "name-of-your-project"
  project          = "gcp-id-of-your-project"
  region           = "region-name"
  vpc_network_name = "name-of-your-vpc-network"

  gke_subnet {
    name                             = "${local.gke_subnet_name}"
    primary_ip_cidr_range            = "CIDR-range-for-primary-subnet"
    services_secondary_range_name    = "secondary-range-name-for-services"
    services_secondary_ip_cidr_range = "secondary-CIDR-range-for-services"
    cluster_secondary_range_name     = "secondary-range-name-for-cluster-pods"
    cluster_secondary_ip_cidr_range  = "secondary-CIDR-range-for-cluster-pods"
  }

  gke_cluster {
    name                                = "name-of-your-gke-cluster"
    private_cluster                     = "is-cluster-private"
    master_ipv4_cidr_block              = "ip-range-for-master"
    daily_maintenance_window_start_time = "HH:MM"
    network_policy_enabled              = "can-cluster-configure-network-policies"
    network_policy_provider             = "name-of-provider" # or "PROVIDER_UNSPECIFIED"
    logging_service                     = "logging.googleapis.com/kubernetes"
    monitoring_service                  = "monitoring.googleapis.com/kubernetes"
  }

  gke_node_pool {
    name         = "name-of-your-gke-node-pool"
    node_count   = "number-of-nodes-per-zone"
    machine_type = "node-pool-machine-type"
    disk_type    = "node-disk-type"
    disk_size_gb = "size-of-node-disk"
    oauth_scopes = ["which-google-api-scopes", "available-on-all-node-VMs"]
    auto_repair  = "should-Google-managed-health-checks-assess state and do repair"
    auto_upgrade = "should-keep-kube-version-up-to-date"
    tags         = ["tags-to-apply-to-nodes", "impacts-firewalls"]
  }

  labels = "${local.labels}"
}

```

For an example of labels, see the [bootstrap project module](https://github.com/thesis/terraform-google-bootstrap-project#usage).

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
## Notes


Be aware: the naming conventions we use at Thesis lean towards verbosity, in the
interest of mking any resource's origin Very explicit. However, this can
collide with GCP resource character limits.

In this module's case, some interpolated names may exceed the character limit
when using the GCP environment name as a prefix, if the environment name
exceeds 11 characters.

For instance: the Thesis standard  vpc_network_name is `<env-name>-vpc-network`,
but in some cases had to be abbreviated to `<en>-vpc-network`.

<!-- License is required -->
## License

See [LICENSE](./LICENSE).
