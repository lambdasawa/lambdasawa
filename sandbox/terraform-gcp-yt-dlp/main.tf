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

resource "google_service_account" "default" {
  account_id   = "sandbox-compute-instance"
  display_name = "Sandbox Service Account"
}

resource "google_project_iam_member" "bucket_list_access" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_compute_instance" "default" {
  name = "yt-dlp"

  # https://cloud.google.com/compute/vm-instance-pricing?hl=ja#n1_predefined
  machine_type = "n1-standard-8"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 1000
      type  = "pd-ssd"
    }
  }

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "default"
  }

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }
}

output "instance_name" {
  value = google_compute_instance.default.name
}
