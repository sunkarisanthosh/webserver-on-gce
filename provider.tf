terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.40.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = "token.json"

}
