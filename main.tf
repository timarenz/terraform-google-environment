# resource "random_string" "random" {
#   length  = 4
#   special = false
#   upper   = false
# }

# resource "google_project" "main" {
#   count           = var.use_existing_project ? 0 : 1
#   name            = "${var.project}-${random_string.random.result}"
#   project_id      = "${var.project}-${random_string.random.result}"
#   org_id          = var.org_id
#   billing_account = var.billing_account
# }

data "google_project" "main" {
  project_id = var.project
}

resource "google_compute_network" "main" {
  name                    = "${var.environment_name}-network"
  auto_create_subnetworks = false
}

locals {
  # project = element(
  #   concat(
  #     data.google_project.main[*].project_id,
  #     google_project.main[*].project_id,
  #   ),
  #   0,
  # )
  project = data.google_project.main.project_id
}

resource "google_compute_subnetwork" "main" {
  count         = length(var.subnets)
  name          = "${var.environment_name}-${lookup(var.subnets[count.index], "name")}"
  project       = local.project
  region        = var.region
  ip_cidr_range = lookup(var.subnets[count.index], "prefix")
  network       = "${google_compute_network.main.self_link}"
}

resource "google_compute_firewall" "default_allow_icmp" {
  name    = "${var.environment_name}-allow-icmp"
  network = google_compute_network.main.self_link

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 65534
}

resource "google_compute_firewall" "default_allow_internal" {
  name    = "${var.environment_name}-allow-internal"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    for i in var.subnets :
    lookup(i, "prefix")
  ]
  priority = 65534
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = "${var.environment_name}-allow-rdp"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 65534
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = "${var.environment_name}-allow-ssh"
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  priority      = 65534
}

resource "google_project_service" "main" {
  project            = local.project
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = var.disable_crm_api_on_destroy
}
