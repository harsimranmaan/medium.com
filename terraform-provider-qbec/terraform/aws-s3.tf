provider "qbec" {}
data "qbec_jsonnet_eval" "aws-s3-deny-non-corp-policy" {
  code = <<EOT
    {
      foo: std.extVar('foo'),
      bar: std.extVar('bar'),
    }
  EOT
  ext_str_vars = {
    foo = "hello"
    bar = "world"
  }
}

// result contains the json object, 
// in this case { foo: 'hello', bar: 'world' }
output "result" {
  value = jsondecode(data.qbec_jsonnet_eval.template.rendered)
}