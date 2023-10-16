
resource "kubernetes_namespace" "nginx_namespace" {
  metadata {
    annotations = {
      name = var.annotation
    }

    labels = {
      mylabel = var.label
    }

    name = var.nginx_namespace_name
  }
}

resource "google_compute_address" "ingress_ip_address" {
  name = "nginx-controller"
}

# Download ingress
resource "helm_release" "nginx_ingress_controller" {
  name       = var.download_nginx_controller_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.nginx_namespace_name
  values = [
    <<EOF
controller:
  service:
    loadBalancerIP: "${google_compute_address.ingress_ip_address.address}"
EOF
  ]
  depends_on = [resource.kubernetes_namespace.nginx_namespace]
}




#TODO make var of loadbalancer ip
#kubectl get svc ingress-nginx-controller -n ingress-nginx -o json | jq -r '.status.loadBalancer.ingress[].ip'


# # Create Ingress to webapp
# resource "kubernetes_ingress_v1" "web_ingress" {
#   wait_for_load_balancer = true
#   metadata {
#     annotations = { 
#       "cert-manager.io/cluster-issuer" = var.cluster_issuer_name
#       "kubernetes.io/ingress.class" = "nginx"
#     }
#     name = var.nginx_controller_name
#     namespace = var.ingress_namespace
#   }
#   spec {
#     tls { 
#       hosts = [var.nginx_hostname]
#       secret_name = var.nginx_controller_secret_name
#     }
#     rule {
#       host = var.nginx_hostname
#       http {
#         path {
#           path = "/"
#           path_type = "Prefix"
#           backend {
#             service {
#               name = var.nginx_ingress_service_name
#               port {
#                 number = 80
#               }
#             }
#           }
#         }
#       }
#     }
#   }
#   depends_on = [resource.helm_release.nginx_ingress_controller]
# }




