resource "google_storage_bucket" "log-bucket" {
  name     = "my-unique-logging-bucket-santhosh"
  location = "EU"
}

# Our sink; this logs all activity related to our "my-logged-instance" instance
resource "google_logging_project_sink" "instance-sink" {
  name        = google_compute_instance.vm.name
  description = "some explanation on what this is"
  destination = "storage.googleapis.com/${google_storage_bucket.log-bucket.name}"
  filter      = "resource.type = gce_instance AND resource.labels.instance_id = \"${google_compute_instance.vm.id}\""

  unique_writer_identity = true
}

# Because our sink uses a unique_writer, we must grant that writer access to the bucket.
resource "google_project_iam_binding" "log-writer" {
  project = "${var.project_id}"
  role = "roles/storage.objectCreator"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]
}
