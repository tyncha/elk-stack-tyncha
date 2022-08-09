module "fluentd_deploy" {
  source                 = "fuchicorp/chart/helm"
  version                = "0.0.12"
  deployment_name        = "fluentd-${var.deployment_environment}"
  deployment_environment = var.deployment_environment
  enabled                = var.elk_architecture_type == "fluentd-elasticksearch-kibana" ? "true" : "false"
  remote_chart           = "true"
  deployment_path        = "fluentd"
  release_version        = var.fluentd["version"]
  chart_repo             = var.fluentd["chart_repo_url"]

  remote_override_values = <<EOF


## Additional environment variables to set for fluentd pods
env:
  - name: "FLUENTD_CONF"
    value: "../../etc/fluent/fluent.conf"
  - name: FLUENT_ELASTICSEARCH_HOST
    value: "elasticsearch-master"
  - name: FLUENT_ELASTICSEARCH_PORT
    value: "9200"

fileConfigs:
  03_dispatch.conf: |-
    <label @DISPATCH>
      <filter **>
        @type prometheus
        <metric>
          name fluentd_input_status_num_records_total
          type counter
          desc The total number of incoming records
          <labels>
            
          </labels>
        </metric>
      </filter>

      <match **>
        @type relabel
        @label @OUTPUT
      </match>
    </label>

dashboards:
  enabled: "false"


EOF
}