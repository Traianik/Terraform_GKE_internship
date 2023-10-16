variable "annotation" {
  description = "K8s namespace annotation"
  type = string
  default = "example-annotation"
}

variable "label" {
  description = "K8s namespace label"
  type = string
  default = "label-value"
}


variable "nginx_namespace_name" {
  description = "K8s namespace name"
  type = string
  default = "ingress-nginx"
}

variable "ingress_namespace" {
  description = "K8s Ingress namespace"
  type = string
  default = "default"
}


variable "download_nginx_controller_name" {
  description = "K8s ingress dwonload controller name"
  type = string
  default = "ingress-nginx"
}


variable "cluster_issuer_name" {
  description = "Cert manager cluster issuer name"
  type = string
  default = "cert-manager-global" 
}



variable "nginx_controller_name" {
  description = "K8s ingress controller name"
  type = string
  default = "ingress-nginx"
}

variable "nginx_controller_secret_name" {
  description = "K8s nginx controller secret"
  type = string
  default = "web-ssl"
}


variable "nginx_hostname" {
  description = "K8s nginx ingress hostname"
  type = string
  default = "test.gfdews.tk"
}

variable "nginx_ingress_service_name" {
  description = "K8s nginx ingress service name"
  type = string
  default = "webapp"
}

