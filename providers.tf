

provider "google" {
  credentials = file("./mygcp-creds.json")
  project = "postgres-g"
  zone    = "us-central1-c"
} 

# RUN AFTER CLUSTER INIT
provider "kubernetes" {
  host  = "https://${module.gke.data_cluster_host.endpoint}"
  token = module.gke.data_google_client_config.access_token
  cluster_ca_certificate = base64decode("${module.gke.data_cluster_host.master_auth[0].cluster_ca_certificate}")
}
 
provider "helm" {
  kubernetes {
    host  = "https://${module.gke.data_cluster_host.endpoint}"
    token = module.gke.data_google_client_config.access_token
    cluster_ca_certificate = base64decode("${module.gke.data_cluster_host.master_auth[0].cluster_ca_certificate}")
  }
}

provider "kubectl" {
  host  = "https://${module.gke.data_cluster_host.endpoint}"
  token = module.gke.data_google_client_config.access_token
  cluster_ca_certificate = base64decode("${module.gke.data_cluster_host.master_auth[0].cluster_ca_certificate}")
}

