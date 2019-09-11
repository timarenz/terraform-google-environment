output "project_id" {
  value = local.project
}

# output "org_id" {
#   value = google_project.main[0].org_id
# }

# output "billing_account" {
#   value = google_project.main[0].billing_account
# }

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
