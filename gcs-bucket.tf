resource "google_storage_bucket" "startup-script" {
  name     = "${var.project_id}-startup-script"
  location = "${var.location}"
  project  = "${var.project_id}"
  uniform_bucket_level_access = true
  storage_class = var.storage_class
  versioning {
    enabled     = true
  }

}

resource "google_storage_bucket_object" "startup-script" {
  name = "webserver/script.txt"
  source = "script.txt"
  bucket  = "${google_storage_bucket.startup-script.name}"
}
