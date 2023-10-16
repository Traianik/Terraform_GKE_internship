variable "annotation" {
  description = "K8s namespace annotation"
  type = string
  default = "my-app-v1"
}

variable "label" {
  description = "K8s namespace label"
  type = string
  default = "mypyapp"
}

variable "argo_namespace_name" {
  description = "K8s namespace name"
  type = string
  default = "argocd" 
}

variable "app_namespace_name" {
  description = "K8s namespace name"
  type = string
  default = "my-application" 
}