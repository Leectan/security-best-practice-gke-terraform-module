variable "cluster_name" {
  description = "Name of the cluster"
  default = "gke-cluster-1"
}

variable "project_id" {
  default = ""
  description = "the project that the cluster resides in"
}

variable "region" {
  default = "us-east1"
  type = string
}

variable "zone" {
  default = "us-east1-b"
  type = string
}

variable "location" {
  default = "us-east1"
  description = "the region or zone for the GKE cluster"
}

variable "master_ipv4_cidr_block" {
  description = "The IP range to use for the hosted master network"
  type = string
  default = "10.5.0.0/28"
}

variable "logging_service" {
  default = "logging.googleapis.com"
  type = string
  description = "Logging service for the cluster, default to logging.googleapis.com"
}

variable "monitoring_service" {
  default = "monitoring.googleapis.com"
  type = string
  description = "Monitoring service for the cluster, default to monitoring.googleapis.com"
}

variable "daily_maintenance_window_start_time" {
  default = "05:00"
  description = "daily maintenance start time"
  type = string
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(any)
  default = [{
    cidr_block = "10.0.0.0/16"
    display_name = "default"
  }]
  description = "Define up to 20 external networks in CIDR that can access Kubernetes Master"
}

variable "cluster_secondary_range_name" {
  default = ""
  type = string
  description = "Name for secondary_range_name"
}

variable "vpc_network_name" {
  default = "gke-network-1"
  type = string
  description = "The network name for the VPC, recommended dedicated VPC for GKE clusters"
}

variable "vpc_subnetwork_name" {
  default = "gke-subnetwork-1"
  type = string
  description = "Name of the subnetwork for the cluster"
}

variable "vpc_subnetwork_cidr_range" {
  default = "10.3.0.0/16"
  type = string
  description = "The IP range for the VPC"
}

variable "network_secondary_range" {
  default = "10.4.0.0/16"
  type = string
  description = "The IP range of the secondary block"
}

variable "network_secondary_range_name" {
  default = "secondary-network-1"
  type = string
  description = "The name of the secondary range IP"
}

variable "cluster_autoscaling" {
  type = string
  default = "enabled"
  description = "Whether node auto-provisioning is enabled"
}

variable "cluster_service_account_name" {
  default = "gke-sbp-service-account"
  type = string
  description = "The name of the service account that used for the GKE cluster"
}


variable "node_pool_name" {
  type = string
  description = "The name of the node_pool"
  default = "gke-node-pool-1"
}

variable "initial_node_count" {
  type = number
  description = "The initial node count of the cluster"
  default = 8
}

variable "max_node_count" {
  type = number
  description = "Max node count"
  default = 6
}

variable "min_node_count" {
  type = number
  description = "Min Node Count"
  default = 2
}

variable "node_auto_repair" {
  type = bool
  description = "whether to enable auto_repair on nodes"
  default = true
}

variable "node_auto_upgrade" {
  type = bool
  description = "whether to enable auto_upgrade"
  default = true

}

variable "node_disk_size_gb" {
  type = number
  description = "the default disk size of the node"
  default = 100
}

variable "node_image_type" {
  type = string
  description = "The OS image that used by cluster"
  default = "COS"
}

variable "node_machine_type" {
  type = string
  description = "machine type for the cluster"
  default = "n1-standard-1"
}

variable "oauth_scopes" {
  type = list(string)
  description = "Permission for cluster to assume"
  default = ["https://www.googleapis.com/auth/cloud-platform",
              "https://www.googleapis.com/auth/devstorage.read_only",
              "https://www.googleapis.com/auth/logging.write",
              "https://www.googleapis.com/auth/monitoring"
  ]

}

variable "node_preemtible" {
  type = bool
  description = "Whether to enable preemtible nodes"
  default = false
}


variable "gke_service_account" {
  type = string
  description = "The Service Account used for gke cluster"
  default = ""
}
