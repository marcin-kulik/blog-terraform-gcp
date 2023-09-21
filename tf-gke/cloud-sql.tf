resource "google_sql_database_instance" "wordpress_instance" {
  name             = "mysql-wordpress-instance"
  region           = var.region
  database_version = "MYSQL_5_7"

  settings {
    tier = var.sql_tier

    backup_configuration {
      enabled = true
    }
  }
  deletion_protection = false
}

resource "google_sql_database" "wordpress_db" {
  name     = "wordpress"
  instance = google_sql_database_instance.wordpress_instance.name
}

resource "google_sql_user" "wordpress_user" {
  name     = "wordpress"
  instance = google_sql_database_instance.wordpress_instance.name
  password = random_password.wp_password.result
  host     = "%"
}

resource "random_password" "wp_password" {
  length           = 24
  special          = true
  override_special = "/@\" "
}
