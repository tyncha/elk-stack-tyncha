module "logstash_deploy" {
  source                  = "fuchicorp/chart/helm"
  version                 = "0.0.12"
  deployment_name         = "logstash-${var.deployment_environment}"
  deployment_environment  = var.deployment_environment
  enabled                 = var.elk_architecture_type == "filebeat-logstash-elasticksearch-kibana" ? "true" : "false"
  remote_chart            = "true"
  deployment_path         = "logstash"
  release_version         = var.logstash["version"]
  chart_repo              = var.logstash["chart_repo_url"]

  remote_override_values = <<EOF
---
logstashPipeline:
  logstash.conf: |
    # all input will come from filebeat, no local logs
    input {
      beats {
        port => 5044
      }
    }
    filter {
      if [message] =~ /^\{.*\}$/ {
        json {
          source => "message"
        }
      }
      if [ClientHost] {
        geoip {
          source => "ClientHost"
        }
      }
    }
    output {
        elasticsearch {
            hosts => [ "elasticsearch-master:9200" ]
        }
    }
      

service:
#  annotations: {}
 type: ClusterIP
 loadBalancerIP: ""
 ports:
   - name: beats
     port: 5044
     protocol: TCP
     targetPort: 5044
   - name: http
     port: 8080
     protocol: TCP
     targetPort: 8080

EOF
}