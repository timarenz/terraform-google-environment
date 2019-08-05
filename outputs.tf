output "network" {
  value = google_compute_network.main.name
}

output "subnets" {
  value = google_compute_subnetwork.main[*].name
}

output "subnet_self_links" {
  value = google_compute_subnetwork.main[*].self_link
}
