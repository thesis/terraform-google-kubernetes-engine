
<!-- Module Name and description are required -->
# Google Kubenetes Engine

Provides a private regional GKE cluster in a dedicated subnet, with a
configurable node pool.

<!-- Compatibility section is optional -->
## Compatibility

| This Module | Terraform | Google Provider |
|-------------|-----------|-----------------|
| v0.1.0      | <= 0.12.0 | <= 1.19.0       |
| v0.2.0      | <= 0.12.0 | <= 2.20.0       |

<!-- Usage section is required -->
## Usage

<!-- NOTE: Examples should go into an `/examples` directory, with a link here
along the following lines:

There are multiple examples included in the [examples](./examples/) folder but
simple usage is as follows:
 -->

Module usage is as follows:

```hcl
module "your_custom_name_for_your_instance_of_this_module" {
  source           = "git@github.com:thesis/this-module-name.git"
  name             = "name-of-your-project"
  project          = "gcp-id-of-your-project"
  region           = "region-name"
  vpc_network_name = "name-of-your-vpc-network"

  gke_subnet {
    name                             = "name-of-your-subnet"
    primary_ip_cidr_range            = "CIDR-range-for-primary-subnet"
    services_secondary_range_name    = "secondary-range-name-for-services"
    services_secondary_ip_cidr_range = "secondary-CIDR-range-for-services"
    cluster_secondary_range_name     = "secondary-range-name-for-cluster-pods"
    cluster_secondary_ip_cidr_range  = "secondary-CIDR-range-for-cluster-pods"
  }

  gke_cluster {
    name                                = "name-of-your-gke-cluster"
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
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gke\_cluster | n/a | `map` | `{}` | no |
| gke\_node\_pool | n/a | `map` | `{}` | no |
| gke\_subnet | n/a | `map` | `{}` | no |
| labels | A list of key/value pairs to describe your resource.  Labels are akin to tags. | `map` | `{}` | no |
| project | The project id of the project you want to create the bucket in. | `string` | `""` | no |
| region | The region where resources are generated. | `string` | `""` | no |
| vpc\_network\_name | Name of the vpc network to associate GKE cluster with. | `string` | `""` | no |

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
<!-- ## Notes -->

<!-- License is required -->
## License

See [LICENSE](./LICENSE).
