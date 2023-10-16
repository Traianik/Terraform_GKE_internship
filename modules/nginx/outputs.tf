
output "ingress_lb_ip" {
  value       = google_compute_address.ingress_ip_address.address
  description = "Ip address load balancer"
}
