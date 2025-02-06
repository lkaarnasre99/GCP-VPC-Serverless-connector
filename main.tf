

resource "google_compute_network" "vpc_network" {
  name = "vpc-test-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "vpc-test-tf-subnet"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc_network.id
  region        = "us-central1"
  private_ip_google_access = true
}

resource "google_vpc_access_connector" "serverless_connector" {
  name               = "my-serverless-connector"
  region             = "us-central1"
  network            = google_compute_network.vpc_network.id
  ip_cidr_range      = "10.0.0.0/29"
  min_throughput     = 200
  max_throughput     = 1000
  machine_type       = "e2-micro"
  subnet       {
    name = google_compute_subnetwork.vpc_subnet.name
  }

  depends_on = [google_compute_subnetwork.vpc_subnet]
}