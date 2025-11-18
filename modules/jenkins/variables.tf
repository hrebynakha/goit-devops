# variable "kubeconfig" {
#   description = "Path to kubeconfig file"
#   type        = string
# }

variable "cluster_name" {
  description = "Name of Kubernetes cluster"
  type        = string
}


variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}


variable "admin_password" {
  type      = string
  sensitive = true
}


variable "github_user" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

