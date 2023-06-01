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
  account_id   = "sandbox-service-account"
  display_name = "Sandbox Service Account"
}

module "gce-container" {
  source  = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"

  container = {
    image = "nginx"

    env = [
      {
        name  = "TEST_VAR"
        value = "Hello World!"
      }
    ]
  }

  restart_policy = "Always"
}

resource "google_compute_instance" "default" {
  name = "sandbox-docker-instance"
  zone = "us-central1-a"

  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = module.gce-container.source_image
    }

    auto_delete = true

    mode = "READ_WRITE"
  }


  labels = {
    container-vm = module.gce-container.vm_container_label
  }

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
  }


  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/lambdasawa-sandbox/regions/us-central1/subnetworks/default"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  tags = ["http-server", "https-server"]
}

output "instance_name" {
  value = google_compute_instance.default.name
}
