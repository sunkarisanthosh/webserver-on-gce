resource "google_compute_disk" "additional-disk-to-webserver" {
  name = "additional-disk-to-webserver"
  type = "pd-ssd"
  zone = "europe-west1-b"
  size = 4
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.additional-disk-to-webserver.id
  instance = google_compute_instance.vm.id
}

