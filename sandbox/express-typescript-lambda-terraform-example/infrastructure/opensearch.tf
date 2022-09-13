locals {
  opensearch_enable         = false
  opensearch_enable_cluster = false
}

resource "aws_opensearch_domain" "example" {
  count = local.opensearch_enable ? 1 : 0

  domain_name = format(
    "%s-%s",
    substr(var.project, 0, 20),
    substr(var.stage, 0, 8),
  )

  engine_version = "OpenSearch_1.1"

  cluster_config {
    dedicated_master_enabled = local.opensearch_enable_cluster
    dedicated_master_type    = "t3.small.search"
    dedicated_master_count   = local.opensearch_enable_cluster ? 3 : 0

    instance_type  = "t3.small.search"
    instance_count = local.opensearch_enable_cluster ? 3 : 1

    zone_awareness_enabled = local.opensearch_enable_cluster
    zone_awareness_config {
      availability_zone_count = 3
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  tags = local.tags
}
