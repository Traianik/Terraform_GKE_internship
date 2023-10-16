variable "project_id" {
  description = "Project id Google Cloud"
  type = string
}

variable "dbinstance" {
  description = "Database instance var"
  type = string
}

variable "dbversion" {
  description = "Database version"
  type = string
}

variable "region" {
  description = "Google Cloud Region"
  type = string
}

variable "dbname" {
  description = "Database name"
  type = string
}

variable "dbuser" {
  description = "Database user"
  type = string
}

variable "dbpassword" {
  description = "Database password"
  type = string
}

variable "tier" {
  description = "Database tier"
  type = string
  default = "db-f1-micro"
}
