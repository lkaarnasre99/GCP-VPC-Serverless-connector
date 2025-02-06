terraform {
  backend "gcs" {
    bucket  = "tf-state-gcs-23"
    prefix  = "terraform/state"
  }
}