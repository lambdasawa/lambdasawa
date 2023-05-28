variable "project_id" {
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

resource "google_service_account" "default" {
  account_id   = "sandbox-service-account"
  display_name = "Sandbox Service Account"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

output "instance_name" {
  value = google_compute_instance.default.name
}
