tfmigrate {
  migration_dir = "./tfmigrate/migration"
  history {
    storage "s3" {
      bucket = "terraform-2023-02-18-14-59-23"
      key    = "tfmigrate/history.json"
    }
  }
}
