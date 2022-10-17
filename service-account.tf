resource "google_service_account" "sa" {
  account_id   = "compute-engine"
  display_name = "Service account for Compute Engine to access start-up script"
}

resource "google_project_iam_binding" "sa" {
  project = "webserver-on-gce"
  role    = "roles/storage.objectViewer"
  members = [
    "serviceAccount:${google_service_account.sa.email}"
  ]
}
