module "filebeat_logstash" {
  source                  = "fuchicorp/chart/helm" 
  version                 = "0.0.12"
  deployment_name         = "filebeat-${var.deployment_environment}"
  deployment_environment  = var.deployment_environment
  enabled                 = var.elk_architecture_type == "filebeat-logstash-elasticksearch-kibana" ? "true" : "false"
  remote_chart            = "true"
  deployment_path         = "filebeat"
  release_version         = var.filebeat["version"]
  chart_repo              = var.filebeat["chart_repo_url"]
  
## Custom terraform configuration
  remote_override_values = <<EOF


resources:
  requests:
    cpu: "60m"
    memory: "100Mi"
  limits:
    cpu: "1000m"
    memory: "200Mi"

EOF
}