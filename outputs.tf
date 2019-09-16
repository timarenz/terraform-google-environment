output "project_id" {
  value = var.project
}

output "region" {
  value = var.region
}

output "network" {
  value = google_compute_network.main.name
}

output "network_self_link" {
  value = google_compute_network.main.self_link
}

output "subnets" {
  value = google_compute_subnetwork.main[*].name
}

output "subnet_self_links" {
  value = google_compute_subnetwork.main[*].self_link
}
