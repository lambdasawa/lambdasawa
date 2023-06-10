variable "project_id" {}

locals {
  instance_name = "book-machine-learning-with-pytorch"
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
  account_id   = "sandbox-book-pytorch"
  display_name = "Sandbox Service Account"
}

resource "google_compute_instance" "default" {
  name = local.instance_name
  zone = "asia-northeast1-a"

  # machine_type = "n1-highmem-4"
  machine_type = "n2-standard-4"

  #  guest_accelerator {
  #    count = 1
  #    type  = "nvidia-tesla-t4"
  #  }

  boot_disk {
    auto_delete = true
    device_name = local.instance_name

    initialize_params {
      image = "projects/ml-images/global/images/c2-deeplearning-pytorch-1-13-cu113-v20230314-debian-10"
      size  = 50
      type  = "pd-ssd"
    }

    mode = "READ_WRITE"
  }


  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "TERMINATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }
}

output "instance_name" {
  value = google_compute_instance.default.name
}
