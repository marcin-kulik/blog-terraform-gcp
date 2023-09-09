resource "google_sql_database_instance" "wordpress_instance" {
  name             = "mysql-wordpress-instance"
  region           = "europe-west2"
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-f1-micro"
  }
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
