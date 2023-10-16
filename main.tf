#TODO  shared vars store in locals on main.tf DONE
#TODO  avoid providing information values of attributes in modules (only if necessary provide default value in variables)

locals {        
  project_id    = ""
  region        = "us-central1"
}

#########
## VPC ##
#########
resource "google_compute_network" "vpc" {
  name                    = "${local.project_id}-vpc"
  auto_create_subnetworks = "false"
}

############
## SUBNET ##
#############
resource "google_compute_subnetwork" "subnet" {
  name                    = "${local.project_id}-subnet"
  region                  = local.region
  network                 = google_compute_network.vpc.name
  ip_cidr_range           = "10.10.0.0/24"
}

########################
## Google K8S Cluster ##
########################
module "gke" {
  source         = "./modules/gke"
  project_id     = local.project_id
  region         = local.region
  zone           = "us-central1-c"   
  network        = google_compute_network.vpc.name
  subnetwork     = google_compute_subnetwork.subnet.name
}

resource "random_password" "password" {
  length = 10
  lower  = false
}


###############
# Google SQL ##
###############
module "pgsql" { 
  source       = "./modules/pgsql"

  project_id   = local.project_id
  region       = local.region    
  dbinstance   = "psql"
  dbversion    = "POSTGRES_13"
  dbname       = "traian"    
  dbuser       = "traian"    
  dbpassword   = random_password.password.result   

}


###################
## Google Bucket ##
###################
resource "google_storage_bucket" "simple-bucket" {
  name          = "mypybucket" 
  location      = "US"
  force_destroy = false
}


####################
##  Cert Manager  ##
####################
module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "traianparii56@gmail.com"
  cluster_issuer_name                    = "cert-manager-global"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"

  depends_on = [ module.gke ]
}

#############
##  Nginx  ##
#############
module "nginx" {
  source                = "./modules/nginx"
  nginx_controller_name = "ingress-test"
  ingress_namespace     = "default"
 
  depends_on = [ module.gke ]
}



##################
#   DNS Record for app   #
##################
resource "google_dns_record_set" "webapp_dns" {
  name = "test.gfdews.tk."  
  type = "A"
  ttl  = 5  
  
  managed_zone = "my-dns"
  
  #instances = ["${module.kafka.instance_ids}"]
  rrdatas = [module.nginx.ingress_lb_ip]

  depends_on = [module.nginx]
}

#############################
#   DNS Record for argocd   #
#############################
resource "google_dns_record_set" "argocd_dns" {
  name = "argocd.gfdews.tk."  
  type = "A"
  ttl  = 5  
  
  managed_zone = "my-dns"
  
  #instances = ["${module.kafka.instance_ids}"]
  rrdatas = [module.nginx.ingress_lb_ip]

  depends_on = [module.nginx]
}


###############
#   Argo CD   #
###############
module "argocd" {
  source        = "./modules/argocd"

  argo_namespace_name = "argocd"
  app_namespace_name = "my-application"
  depends_on = [ module.cert_manager ]
}



##################
#   Google KMS   #
##################
# resource "google_kms_key_ring" "my_key_ring" {
#   # Create the key ring on GCP
#   project  = local.project_id
#   name     = "sops-terraform"
#   location = "global"

# }

# resource "google_kms_crypto_key" "my_crypto_key" {
#   # Add a new create to the key ring
#   name     = "sops-key"
#   key_ring = google_kms_key_ring.my_key_ring.id
# }
 


