variable "kubernetes_version" {
  type        = string
  default     = "latest"
  description = "the Kubernetes version of the master, set to latest will pull the latest version"
}

variable "network_project" {
  type        = string
  description = "The Project ID of the shared VPC's host"
  default     = ""
}



variable "project_id" {
  description = "The Project ID to hose the cluster in"
  type        = string
}

variable "location" {
  type        = string
  description = "the location (region or zone to host the cluster in"
}


variable "cluster_name" {
  type        = string
  description = "the name of the cluster"
}

variable "vpc_network" {
  type        = string
  description = "A reference (self link) to the vpc network to host the cluster in"
}

variable "vpc_subnetwork" {
  type        = string
  description = "a reference self link to the vpc subnetwork"
}

variable "cluster_secondary_range_name" {
  type        = string
  description = "the name of the secondary range within the subnetwork for the cluster to use"
}

variable "monitoring_service" {
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
  description = "The monitoring service that the cluster should write metrics to"
}

variable "logging_service" {
  type        = string
  description = "The logging service that the cluster should write logs to"
  default     = "logging.googleapis.com/kubernetes"
}

variable "daily_maintenance_window_start_time" {
  description = "Time window specified for daily maintenance operations in the cluster"
  type        = string
  default     = "05:00"
}

variable "enable_private_endpoint" {
  type        = bool
  default     = true
  description = "Whether to enable nodes to communicate with master through private endpoint"

}

variable "enable_private_nodes" {
  type        = bool
  default     = false
  description = "Control whether nodes have internal IP addresses only"
}

variable "master_ipv4_cidr_block" {
  type        = string
  default     = ""
  description = "The IP range in CIDR notaion to use for the hosted master network"
}

variable "use_ip_aliases" {
  type = bool
  default = true
  description = "whether  alias IPs will be used for pod IPs in the cluster"
}

variable "enable_network_policy" {
  description = "Whether to enable Kubernetes NetworkPolicy on the master, which is required to be enabled to be used on Nodes."
  type        = bool
  default     = true
}

variable "enable_kubernetes_dashboard" {
  description = "Whether to enable the Kubernetes Web UI (Dashboard). The Web UI requires a highly privileged security account."
  type        = bool
  default     = false
}

variable "http_load_balancing" {
  description = "Whether to enable the http (L7) load balancing addon"
  type        = bool
  default     = true
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(any)
  default = [{
    cidr_block   = "10.0.0.0/16"
    display_name = "default"
  }]
  description = "Define up to 20 external networks in CIDR that can access Kubernetes Master"
}

variable "cluster_autoscaling" {
  type        = string
  default     = "enable"
  description = "Whether to enable node auto-provisioning with cluster autoscaler "
}

variable "enable_legacy_abac" {
  type        = bool
  default     = false
  description = "Whether the ABAC authorizer is enabled for this cluster"
}

variable "cluster_client_certificate" {
  type        = bool
  default     = true
  description = "To enforce SSL/TSL communication to the cluster"
}

variable "pod_security_policy_config" {
  type        = bool
  default     = true
  description = "Enable the PodSecurityPolicy controller for this cluster"
}

variable "node_cluster_auto_scaling" {
  type = bool
  default = true
  description = "Whether node auto-provisioning is enabled"
}

variable "cpu_minimum" {
  type = number
  default = 2
  description = "the minimum core for cluster node"
}

variable "cpu_maximum" {
  type = number
  default = 4
  description = "the maximum core for the cluster node"
}

variable "memory_maximum" {
  type = number
  default = 8
  description = "the max memory for the node cluster"
}

variable "memory_minimum" {
  type = number
  default = 4
  description = "the min memory for the node cluster"
}

variable "intranode_visibility" {
  type = bool
  description = "intranode_visibility will make same node pod to pod traffic visible for VPC network"
  default = true
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







