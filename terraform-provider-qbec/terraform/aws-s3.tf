terraform {
  required_providers {
    qbec = {
      source = "splunk/qbec"
      version = "0.0.1"
    }
  }
}
provider "qbec" {}

data "qbec_jsonnet_eval" "aws-s3-deny-non-corp-policy" {
  file = "${path.module}/../policy.jsonnet"
  data_sources = [
    "exec://my-corp-ip-api?configVar=corpIPsKey"
  ]
  ext_code_vars = {
    corpIPsKey = jsonencode({
      command : "${path.module}/../fetch-dynamic-corp-ips.sh",
      args : ["corpIPs"]
    })
  }
}

// result contains the policy json object
output "result" {
  value = jsondecode(data.qbec_jsonnet_eval.aws-s3-deny-non-corp-policy.rendered)
}

# Use the policy on desired terraform objects
# resource "aws_s3_bucket" "b" {
#   bucket = "the-bucket"
#   policy = data.qbec_jsonnet_eval.aws-s3-deny-non-corp-policy.rendered
# }