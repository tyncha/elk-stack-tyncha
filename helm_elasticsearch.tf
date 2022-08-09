module "elasticsearch_deploy" {
  source                 = "fuchicorp/chart/helm"
  version                = "0.0.12"
  deployment_name        = "elasticsearch-${var.deployment_environment}"
  deployment_environment = var.deployment_environment
  deployment_endpoint    = "elasticsearch.${var.google_domain_name}"
  enabled                = var.elasticsearch["enabled"]
  remote_chart           = "true"
  deployment_path        = "elasticsearch"
  release_version        = var.elasticsearch["version"]
  chart_repo             = var.elasticsearch["chart_repo_url"]

  remote_override_values = <<EOF

replicas: 1
minimumMasterNodes: 1

esJavaOpts: "-Xmx512m -Xms512m"

resources:
  requests:
    cpu: "1000m"
    memory: "1Gi"
  limits:
    cpu: "1000m"
    memory: "1Gi"

volumeClaimTemplate:
  accessModes: [ "ReadWriteOnce" ]
  resources:
    requests:
      storage: 10Gi

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
  - "elasticsearch.${var.google_domain_name}"
  tls:
  - secretName: chart-elasticsearch-tls
    hosts:
    - "elasticsearch.${var.google_domain_name}"

EOF
}
