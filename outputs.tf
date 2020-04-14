output "endpoint" {
  description = "The IP address of this cluster's Kubernetes master."
  value       = "${google_container_cluster.a_gke_cluster.endpoint}"
}

output "public_endpoint" {
  description = "The IP address of this cluster's Kubernetes master."
  value       = "${google_container_cluster.a_gke_cluster.endpoint}"
}

output "cluster_ca_certificate" {
  description = "Base64 encoded public certificate that is the root of trust for the cluster."
  value       = "${google_container_cluster.a_gke_cluster.master_auth.0.cluster_ca_certificate}"
}

output "name" {
  description = "The name of the GKE cluster."
  value       = "${google_container_cluster.a_gke_cluster.name}"
}

output "vpc_gke_subnet_self_link" {
  description = "The URI of the GKE subnet."
  value       = "${google_compute_subnetwork.a_gke_subnet.self_link}"
}

output "vpc_gke_subnet_name" {
  description = "The name of your created public subnet."
  value       = "${google_compute_subnetwork.a_gke_subnet.name}"
}
