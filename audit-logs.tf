resource "google_project_iam_audit_config" "storage-service" {
  project = "${var.project_id}"
  service = "storage.googleapis.com"
  audit_log_config {
#     log_type = "ADMIN_READ"  #Records operations that read metadata or configuration information.
  }
  audit_log_config {
    log_type = "DATA_READ" #Records operations that read user-provided data.
  }
  audit_log_config {
    log_type = "DATA_WRITE" #Records operations that write user-provided data.
  }
}
