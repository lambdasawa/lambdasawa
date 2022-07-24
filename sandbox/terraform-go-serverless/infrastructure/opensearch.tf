resource "aws_opensearch_domain" "main" {
  count = local.create_open_search ? 1 : 0

  domain_name    = "sandbox-tf-go-sl-main"
  engine_version = "Elasticsearch_7.10"

  cluster_config {
    instance_type = "t3.small.search"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  tags = local.tags
}
