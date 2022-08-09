data "template_file" "success_output" {
  template = file("terraform_templates/output.txt")

  vars = {
    ## Elk structure type
    elk_structure = var.elk_architecture_type

    ## Getting the kibana endpoint 
    kibana_endpoint = "https://kibana.${var.google_domain_name}"

    ## Getting the elastic search endpoint 
    elastic_search_endpoint = "https://elasticsearch.${var.google_domain_name}"
  }
}

output "Success" {
  value = data.template_file.success_output.rendered
}
