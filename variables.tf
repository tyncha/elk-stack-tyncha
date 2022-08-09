variable "google_domain_name" {
  type        = string
  description = "– (Required) Relative name of the domain serving the application."
}

variable "google_project_id" {
  type        = string
  description = "– (Required) Relative name of the domain serving the application."
}

variable "google_bucket_name" {
  type        = string
  description = "– (Required) Relative name of the domain serving the application."
}

variable "custom_403_endpoint" {
  default     = "https://academy.fuchicorp.com/accounting/plans/"
  description = "-(Optional) All non whitelisted people will be redirected to."
}

variable "common_tools_access" {
  type = list

  default = [
    "10.40.0.13/8",       ## Cluster access
    "34.133.222.35/32",   ## Fuchicorp bastion host
    "24.14.53.36/32",     ## Farkhod Sadykov
    "67.167.220.165/32",  ## Kelly Salrin
    "106.168.195.106/32", ## Asiat Osmonova
  ]

  description = "-(Optional) Lits of IP ranges to whitelist all common tools."
}

variable "elasticsearch"{
  type  = map

  default = {
    version = "7.8.0"
    enabled = "true"
    chart_repo_url = "https://helm.elastic.co"
  }
}

variable "kibana" {
  type = map

  default = {
    version = "7.8.0"
    enabled = "true"
    chart_repo_url = "https://helm.elastic.co"
  }
}

variable "fluentd" {
  type = map

  default = {
    version = "0.2.6"
    enabled = "false"
    chart_repo_url = "https://fluent.github.io/helm-charts"
  }
}

variable "filebeat" {
  type = map

  default = {
    version = "7.8.0"
    enabled = "false"
    chart_repo_url = "https://helm.elastic.co"
  }
}

variable "logstash" {
  type = map

  default = {
    version = "7.13.2"
    enabled = "false"
    chart_repo_url = "https://helm.elastic.co"
  }
}

variable "elk_architecture_type" {
  default     = "filebeat-elasticksearch-kibana"
  description = "-(Optional) Choice architecture type <filebeat-elasticksearch-kibana> <filebeat-logstash-elasticksearch-kibana> <fluentd-elasticksearch-kibana>"
}

variable "deployment_name" {
  type        = string
  description = "– (Required) Name of your deployment."
}

variable "deployment_environment" {
  type        = string
  description = "– (Required) Environment (namespace) where you want to deploy ELK."
}