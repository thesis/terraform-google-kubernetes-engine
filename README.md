
<!-- Module Name and description are required -->
# Google Kubenetes Engine

<!-- TODO: Add description -->

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
Sample module block showing required fields configured.  You can have
multiple examples if it makes sense for the module.

```hcl
module "your_custom_name_for_your_instance_of_this_module" {
  source                = "git@github.com:thesis/this-module-name.git"
  name                  = "name-of-your-project"
  org_id                = "your-org-id"
  billing_account       = "your-billing-account"
  project_owner_members = ["john@email.co", "lilly@email.co",]
  location              = "us-central1"
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
## Notes

Anything quirky about the module folks may want to know about. Relevant
links or additional useful information.  Format is up to you.

<!-- License is required -->
## License

See [LICENSE](./LICENSE) for full details.

<!-- Before open-sourcing this module, Remove this comment and update the
  LICENSE file at the repo root. Else: Copyright Thesis, Inc., 2020 -->
