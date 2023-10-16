terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.61.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.19.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.13.0"
    }
    argocd = {
      source = "oboukili/argocd"
      version = "5.3.0"
    }

  }
  backend "gcs" {
    bucket  = "mypybucket"  
    prefix  = "terraform/state" 
    # credentials = "./mygcp-creds.json"
  } 

  required_version = ">= 0.14"
}

