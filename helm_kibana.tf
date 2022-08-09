module "kibana_deploy" {
  source                 = "fuchicorp/chart/helm"
  version                = "0.0.12"
  deployment_name        = "kibana-${var.deployment_environment}"
  deployment_environment = var.deployment_environment
  deployment_endpoint    = "kibana.${var.google_domain_name}"
  enabled                = var.kibana["enabled"]
  remote_chart           = "true"
  deployment_path        = "kibana"
  release_version        = var.kibana["version"]
  chart_repo             = var.kibana["chart_repo_url"]

  remote_override_values = <<EOF
---
resources:
  requests:
    cpu: "256m"
    memory: "1Gi"
  limits:
    cpu: "512m"
    memory: "1Gi"
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/whitelist-source-range: ${join(",",var.common_tools_access)}
    nginx.ingress.kubernetes.io/server-snippet: |
      error_page 403 ${var.custom_403_endpoint};
  path: /
  hosts:
  - "kibana.${var.google_domain_name}"
  tls: 
  - secretName: chart-kibana-tls
    hosts:
    - "kibana.${var.google_domain_name}"
EOF
}
