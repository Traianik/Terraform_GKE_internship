
#Namespace for app
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    annotations = {
      name = var.annotation
    }

    labels = {
      mylabel = var.label
    }

    name = var.app_namespace_name
  }
}

#install argocd
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = var.argo_namespace_name
  create_namespace = true
  version          = "5.33.1" 

}

# resource "null_resource" "apply_yaml" {
#   provisioner "local-exec" {
#     command = "kubectl apply -f ./modules/argocd/argocd.yaml"
#   }

#   depends_on = [ helm_release.argocd ]
# }


# Create Ingress to argocd on HTTPS
resource "kubernetes_ingress_v1" "web_ingress" {
  wait_for_load_balancer = true
  metadata {

    name = "ingress-test1"
    namespace = var.argo_namespace_name

    annotations = { 
      
      "cert-manager.io/cluster-issuer" = "cert-manager-global"
      "kubernetes.io/ingress.class" = "nginx"
      "nginx.ingress.kubernetes.io/ssl-passthrough" = "true"
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"

    }
    
  }
  spec {
    rule {
      host = "argocd.gfdews.tk"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "argocd-server"
              port { 
                name = "https"
              }
            }
          }
        }
      }
    }
    tls {
      hosts = [ "argocd.gfdews.tk" ]
      secret_name = "argocd-secret"
    }
  }
  depends_on = [ helm_release.argocd ]
}


