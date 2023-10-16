resource "google_sql_database_instance" "master" {
  name             = var.dbinstance
  database_version = var.dbversion #"POSTGRES_13"
  region           = var.region
  deletion_protection=false
  
  settings {
    tier = var.tier # default
    ip_configuration {
        ipv4_enabled = true
    }
  }
}

resource "google_sql_database" "database" {
  name      = var.dbname
  instance  = google_sql_database_instance.master.name

  depends_on = [
    google_sql_database_instance.master
  ]  
}

resource "google_sql_user" "users" {
  name     = var.dbuser
  instance = google_sql_database_instance.master.name
  password = var.dbpassword

  depends_on = [
    google_sql_database.database
  ]  
}