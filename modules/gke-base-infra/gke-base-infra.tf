

##############
# Set Locals
##############

locals {
  latest_version     = data.google_container_engine_versions.location.latest_master_version
  kubernetes_version = var.kubernetes_version != "latest" ? var.kubernetes_version : local.latest_version
  network_project    = var.network_project != "" ? var.network_project : var.project_id
  standard_tags = {
    Compoent    = "gke-sbp-cluster"
    Environment = "production"
  }


}

###################
# Get available master versions in our location to determine the latest version
###################
data "google_container_engine_versions" "location" {
  location = var.location
  project  = var.project_id
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

##########
# Create Base GKE Cluster
##########

resource "google_container_cluster" "gke_cluster" {
  name = var.cluster_name
  project = var.project_id
  location = var.location
  network = var.vpc_network
  subnetwork = var.vpc_subnetwork
  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service
  min_master_version = local.kubernetes_version

  ####
  # Remove Node Pool and set initial node count
  ####
  remove_default_node_pool = true
  initial_node_count = 4
    maintenance_policy {
      daily_maintenance_window {
        start_time = var.daily_maintenance_window_start_time
      }
    }
  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes = var.enable_private_nodes
    master_ipv4_cidr_block = var.master_ipv4_cidr_block

  }
  //
  #Enable network policy for ip masquerade agent feature
  network_policy {
    enabled = var.enable_network_policy
    provider = "CALICO"
  }

  enable_legacy_abac = var.enable_legacy_abac

  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = var.cluster_client_certificate
    }
  }
  addons_config {
    kubernetes_dashboard {
      disabled = var.enable_kubernetes_dashboard
    }
    http_load_balancing {
      disabled = var.http_load_balancing
    }
    # whether to enable network policy addon for the master cluster
    network_policy_config {
      disabled = var.enable_network_policy
    }
  }
  ip_allocation_policy {
    use_ip_aliases = var.use_ip_aliases
    cluster_secondary_range_name = var.cluster_secondary_range_name
    services_secondary_range_name = var.cluster_secondary_range_name
  }


  pod_security_policy_config {
    enabled = var.pod_security_policy_config
  }



//  cluster_autoscaling {
//    enabled = var.node_cluster_auto_scaling
//    resource_limits {
//      resource_type = "cpu"
//      minimum = var.cpu_minimum
//      maximum = var.cpu_maximum
//    }
//    resource_limits {
//      resource_type = "memory"
//      minimum = var.memory_maximum
//      maximum = var.memory_minimum
//    }
//  }



  enable_intranode_visibility = var.intranode_visibility

//  tags = {
//    key                 = "Name"
//    value               = "example_name"
//    propagate_at_launch = false
//  }
//
//  dynamic "tags" {
//    for_each = local.standard_tags
//    content {
//      key                 = tags.key
//      value               = tags.value
//      propagate_at_launch = true
//    }
//  }



  master_authorized_networks_config {
//    cidr_blocks {
//      cidr_block = var.master_authorized_networks_cidr_blocks
//    }

  }


}

//resource "google_container_node_pool" "node_pool_1" {
//  provider           = "google-beta"
//  cluster            = google_container_cluster.gke_cluster.name
//  name               = var.node_pool_name
//  location           = var.location
//  project            = var.project_id
//  initial_node_count = var.initial_node_count
//
////  autoscaling {
////    max_node_count = var.max_node_count
////    min_node_count = var.min_node_count
////  }
//  management {
//    auto_repair  = var.node_auto_repair
//    auto_upgrade = var.node_auto_upgrade
//  }
//
//  node_config {
//    disk_size_gb    = var.node_disk_size_gb
//    image_type      = var.node_image_type
//    machine_type    = var.node_machine_type
//    service_account = var.gke_service_account
//    oauth_scopes    = var.oauth_scopes
//    preemptible     = var.node_preemtible
//
//  }
//
//
//}


output "gke-sbp-cluster-name" {
  value = google_container_cluster.gke_cluster.name
}




