module "filebeat_only" {
  source                  = "fuchicorp/chart/helm" 
  version                 = "0.0.12"
  deployment_name         = "filebeat-${var.deployment_environment}"
  deployment_environment  = var.deployment_environment
  enabled                 = var.elk_architecture_type == "filebeat-elasticksearch-kibana" ? "true" : "false"
  remote_chart            = "true"
  deployment_path         = "filebeat"
  release_version         = var.filebeat["version"]
  chart_repo              = var.filebeat["chart_repo_url"]
  
## Custom terraform configuration
  remote_override_values = <<EOF
  EOF
}