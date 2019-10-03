# use this data provider to expose an access token for communicating with the GKE cluster.
data "google_client_config" "client" {}

module "gke-sbp-cluster" {
  providers = {
    google = "google-beta"
  }
  source = "./modules/gke-base-infra"
  cluster_name = var.cluster_name
  project_id = var.project_id
  vpc_network = google_compute_network.vpc_network.name
  vpc_subnetwork = google_compute_subnetwork.vpc_subnetwork.name
  location = var.location
  master_ipv4_cidr_block = var.master_ipv4_cidr_block
  use_ip_aliases = true
  logging_service = var.logging_service
  monitoring_service = var.monitoring_service
  daily_maintenance_window_start_time = var.daily_maintenance_window_start_time
  enable_private_endpoint = false
  cluster_client_certificate = true
  enable_kubernetes_dashboard = true
  enable_private_nodes = true
  enable_network_policy = true
  http_load_balancing = false
  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
  cluster_secondary_range_name = var.cluster_secondary_range_name
  cluster_autoscaling = var.cluster_autoscaling
  enable_legacy_abac = false
  pod_security_policy_config = true
  intranode_visibility = true


//  #node pool configs below
//  node_pool_name = "gke-node_pool-1"
//  initial_node_count = 4
////  max_node_count = 4
////  min_node_count = 2
//  node_auto_repair = true
//  node_auto_upgrade = true
//  node_disk_size_gb = 100
//  node_image_type = "COS"
//  node_machine_type = "n1-standard-1"
//  oauth_scopes = [
//                  "https://www.googleapis.com/auth/logging.write",
//                  "https://www.googleapis.com/auth/monitoring",
//                  "https://www.googleapis.com/auth/devstorage.read_only"
//
//  ]
//  node_preemtible = false
//  gke_service_account = module.gke_service_account.email
////  node_cluster_auto_scaling = true
////  cpu_maximum = 4
////  cpu_minimum = 2
////  memory_maximum = 8
////  memory_minimum = 4
}


resource "google_container_node_pool" "node_pool_1" {
  provider           = "google-beta"
  cluster            = module.gke-sbp-cluster.gke-sbp-cluster-name
  name               = var.node_pool_name
  location           = var.location
  project            = var.project_id
  initial_node_count = var.initial_node_count

  autoscaling {
    max_node_count = var.max_node_count
    min_node_count = var.min_node_count
  }
  management {
    auto_repair  = var.node_auto_repair
    auto_upgrade = var.node_auto_upgrade
  }

  node_config {
    disk_size_gb    = var.node_disk_size_gb
    image_type      = var.node_image_type
    machine_type    = var.node_machine_type
    service_account = module.gke_service_account.google-service-account
    oauth_scopes    = var.oauth_scopes
    preemptible     = var.node_preemtible

  }
}

module "gke_service_account" {
  source = "./modules/gke-service-account"
  name = var.cluster_service_account_name
  project_id = var.project_id
}



resource "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
  delete_default_routes_on_create = true
  project = var.project_id
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  ip_cidr_range = var.vpc_subnetwork_cidr_range
  project = var.project_id
  name = var.vpc_subnetwork_name
  network = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
  secondary_ip_range {
    ip_cidr_range = var.network_secondary_range
    range_name = var.network_secondary_range_name
  }
  enable_flow_logs = true
}

//resource "random_string" "suffix" {
//  length = 4
//  special = false
//  upper = false
//}
