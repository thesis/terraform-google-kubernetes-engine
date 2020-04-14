# Enable GKE APIs
resource "google_project_service" "container" {
  project = "${var.project}"
  service = "container.googleapis.com"
}

# Import existing VPC data.
data "google_compute_network" "gke_vpc" {
  project = "${var.project}"
  name    = "${var.vpc_network_name}"
}

resource "google_container_cluster" "a_gke_cluster" {
  project = "${var.project}"
  name    = "${lookup(var.gke_cluster, "name", "")}"
  region  = "${var.region}"

  private_cluster        = "${lookup(var.gke_cluster, "private_cluster", "")}"
  network                = "${data.google_compute_network.gke_vpc.self_link}"
  subnetwork             = "${google_compute_subnetwork.a_gke_subnet.self_link}"
  master_ipv4_cidr_block = "${lookup(var.gke_cluster, "master_ipv4_cidr_block", "")}"

  # Empty to disable.
  master_auth {
    username = ""
    password = ""

    # False to disable.
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Empty to disable access.
  master_authorized_networks_config = {}

  # calico is the only provider offered, so it's coded here.
  network_policy {
    provider = "${lookup(var.gke_cluster, "network_policy_provider", "PROVIDER_UNSPECIFIED")}"
    enabled  = "${lookup(var.gke_cluster, "network_policy_enabled", false)}"
  }

  ip_allocation_policy {
    services_secondary_range_name = "${lookup(google_compute_subnetwork.a_gke_subnet.secondary_ip_range[0], "range_name")}"
    cluster_secondary_range_name  = "${lookup(google_compute_subnetwork.a_gke_subnet.secondary_ip_range[1], "range_name")}"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "${lookup(var.gke_cluster, "daily_maintenance_window_start_time", "")}"
    }
  }

  logging_service    = "${lookup(var.gke_cluster, "logging_service", "logging.googleapis.com")}"
  monitoring_service = "${lookup(var.gke_cluster, "monitoring_service", "monitoring.googleapis.com")}"

  # Adds labels to the GCE resource.
  resource_labels = "${var.labels}"

  /* initial_node_count and remove_default_node_pool are
   * non-configurable to keep folks from tinkering for now.
   * We don't want to use the default node pool, instead
   * we opt for a configured node_pool.  This configuration
   * will create the minimum number of resources, then remove
   * them.
  */

  initial_node_count       = 1
  remove_default_node_pool = true
  depends_on               = ["google_project_service.container"]
}

resource "google_container_node_pool" "a_gke_node_pool" {
  project = "${var.project}"
  name    = "${lookup(var.gke_node_pool, "name", "")}"
  region  = "${var.region}"
  cluster = "${google_container_cluster.a_gke_cluster.name}"

  node_count = "${lookup(var.gke_node_pool, "node_count", "")}"

  node_config {
    machine_type = "${lookup(var.gke_node_pool, "machine_type", "")}"
    disk_type    = "${lookup(var.gke_node_pool, "disk_type", "")}"
    disk_size_gb = "${lookup(var.gke_node_pool, "disk_size_gb", "")}"
    oauth_scopes = ["${split(",", lookup(var.gke_node_pool, "oauth_scopes", "https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring"))}"]

    tags   = ["${split(",", lookup(var.gke_node_pool, "tags", ""))}"]
    labels = "${var.labels}"

    metadata {
      disable-legacy-endpoints = "true"
    }
  }

  management {
    auto_repair  = "${lookup(var.gke_node_pool, "auto_repair", "")}"
    auto_upgrade = "${lookup(var.gke_node_pool, "auto_upgrade", "")}"
  }

  autoscaling {
    min_node_count = "${lookup(var.gke_node_pool, "node_count", "")}"
    max_node_count = "${lookup(var.gke_node_pool, "node_count", "")}"
  }
}

resource "google_compute_subnetwork" "a_gke_subnet" {
  project                  = "${var.project}"
  name                     = "${lookup(var.gke_subnet, "name", "")}"
  region                   = "${var.region}"
  network                  = "${data.google_compute_network.gke_vpc.self_link}"
  ip_cidr_range            = "${lookup(var.gke_subnet, "primary_ip_cidr_range", "")}"
  private_ip_google_access = true

  secondary_ip_range = {
    range_name    = "${lookup(var.gke_subnet, "services_secondary_range_name", "")}"
    ip_cidr_range = "${lookup(var.gke_subnet, "services_secondary_ip_cidr_range", "")}"
  }

  secondary_ip_range = {
    range_name    = "${lookup(var.gke_subnet, "cluster_secondary_range_name", "")}"
    ip_cidr_range = "${lookup(var.gke_subnet, "cluster_secondary_ip_cidr_range", "")}"
  }
}
