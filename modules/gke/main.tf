data "google_client_config" "default" {
}

# GKE cluster 
resource "google_container_cluster" "primary" {
  name                    = "${var.project_id}-gke2"
  location = var.zone
  initial_node_count = var.initial_node_count 

  network    = var.network
  subnetwork = var.subnetwork
}

data "google_container_cluster" "my_cluster" {
  name = google_container_cluster.primary.name
}
