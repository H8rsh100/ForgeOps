variable "cluster_name" {
  type        = string
  description = "Name of the Kind Kubernetes cluster"
  default     = "forgeops-cluster"
}

variable "node_image" {
  type        = string
  description = "Docker image for Kind nodes (Kubernetes version)"
  default     = "kindest/node:v1.28.0"
}

variable "environment" {
  type        = string
  description = "Target deployment environment (dev/staging/prod)"
  default     = "dev"
}
