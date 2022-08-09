## Terraform module for ELK

To be able to use following terraform module please follow the documentation. 


## Requirements

* Terraform >= 0.13.7
* Helm >=2.8.0 and <3.0.0
* Kubernetes >=1.20
* You should have an access to your Kubernetes cluster

## Usage

Step 1. Clone repository
```
git clone https://github.com/fuchicorp/elk-stack.git
```

Step 2. Create `elk.tfvars` Please provide whitelisted ip ranges. It should look like this. 

```
deployment_name                 = "elk-stack"
deployment_environment          = "elk"
google_domain_name              = "fuchicorp.com"
google_bucket_name              = "fuchicorp70"
google_project_id               = "fluent-cyclist-330623"
elk_architecture_type           = "filebeat-elasticksearch-kibana" # <filebeat-elasticksearch-kibana> <filebeat-logstash-elasticksearch-kibana> <fluentd-elasticksearch-kibana>
common_tools_access = [ 
  "10.16.0.27/8",             # Cluster access 
  "104.181.144.186/32",       # Office IP1
  "98.215.33.68/32",          # Add your IP address (Required)
  "24.14.53.36/32",            ## fsadykov home  
  "67.167.220.165/32"            # Kelly
]
```

Step 3. Provide GIT_TOKEN because you need a GIT_TOKEN to be able to execute set-env.sh script.

Step 4. Export KUBE_CONFIG_PATH so that Terraform will have access to Kubernetes cluster, command is `export KUBE_CONFIG_PATH=~/.kube/config`

Step 5. After you finish with defining all required variables go ahead and run `source set-env.sh elk.tfvars` and than run `terraform apply -var-file=$DATAFILE`

```
source set-env.sh elk.tfvars
terraform apply -var-file=$DATAFILE
```

## Variables

For more info, please see the [variables file](?tab=inputs).

| Variable               | Description                         | Default                                               | Type |
| :--------------------- | :---------------------------------- | :---------------------------------------------------: | :--------------------: |
| `google_domain_name` | Relative name of the domain serving the application. | `(Required)` | `string` |
| `deployment_name` |  Name of your deployment. | `(Required)` | `string` |
| `deployment_environment` | Environment (namespace) where you want to deploy ELK | `(Required)` | `string` |
| `credentials` | Your google service account example.json | `(Required)` | `string` |
| `google_bucket_name` | The name of the bucket. | `(Required)` | `string` |
| `google_project_id` | The ID of the project in which the resource belongs. If it is not provided, the provider project is used | `(Required)` | `string` |
| `elk_architecture_type` | choose one of these option `filebeat-elasticksearch-kibana` or  `filebeat-logstash-elasticksearch-kibana` or `fluentd-elasticksearch-kibana` | `(Required)` | `string` |



If you have any issues please feel free to submit the issue [new issue](https://github.com/fuchicorp/terraform-aws-eks/issues/new) 

Developed by FuchiCorp members 