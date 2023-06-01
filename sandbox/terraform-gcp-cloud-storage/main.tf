variable "project_id" {
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }

  backend "gcs" {}
}

provider "google" {
  project = var.project_id
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

resource "google_storage_bucket" "main" {
  name          = "lambdasawa-sandbox-terraform-cloud-storage"
  location      = "ASIA"
  force_destroy = true
}
