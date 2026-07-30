output "cluster_name" {
  value       = kind_cluster.default.name
  description = "The name of the provisioned Kind cluster"
}

output "cluster_endpoint" {
  value       = kind_cluster.default.endpoint
  description = "Kubernetes API endpoint URL"
}

output "kubeconfig_path" {
  value       = kind_cluster.default.kubeconfig_path
  description = "Path to the generated kubeconfig file"
}

output "cluster_context" {
  value       = "kind-${kind_cluster.default.name}"
  description = "kubectl context name"
}
