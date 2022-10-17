resource "google_storage_bucket" "log-bucket" {
  name     = "bucket-to-store-webserver-logs"
  location = "EU"
}

resource "google_logging_project_sink" "instance-sink" {
  name        = google_compute_instance.vm.name
  description = "bucket-to-store-webserver-logs"
  destination = "storage.googleapis.com/${google_storage_bucket.log-bucket.name}"
  filter      = "resource.type = gce_instance AND resource.labels.instance_id = \"${google_compute_instance.vm.id}\""

  unique_writer_identity = true
}

resource "google_project_iam_binding" "log-writer" {
  project = "${var.project_id}"
  role = "roles/storage.objectCreator"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]
}
