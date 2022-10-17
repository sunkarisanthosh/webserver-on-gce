data "google_compute_image" "debian" {
  family  = "debian-11"
  project = "debian-cloud"
}

# Creates a GCP VM Instance.  Metadata Startup script install the Nginx webserver.
resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["http-server"]
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link
    }
  }

  network_interface {
    # network = "default"
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.public.name
    
    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    startup-script-url = "gs://${google_storage_bucket.startup-script.name}/${google_storage_bucket_object.startup-script.name}"

  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.sa.email
    scopes = ["cloud-platform"]
  }


}

