variable "project_id" {
  description = "Project id Google Cloud"
  type = string
}

variable "region" {
  description = "Google Cloud Region"
  type = string
}

variable "zone" {
  description = "Google Cloud Zone"
  type = string
}

variable "initial_node_count" {
  description = "Node count"
  type = string
  default = "2"
}

variable "ip_cidr_range" {
  description = "Google cloud ip_cidr_range"
  type = string
  default = "10.10.0.0/24"
}


variable "dns_zone_name" {
  description = "K8s DNS Zone Name"
  type = string
  default = "my-dns"
}


variable "subdomain_name" {
  description = "K8s Subdomain"
  type = string
  default = "test.gfdews.tk."
}

variable "network" {
  description = "Network for the GKE cluster"
}

variable "subnetwork" {
  description = "Subnetwork for the GKE cluster"
}
