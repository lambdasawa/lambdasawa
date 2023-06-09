resource "aws_ecr_repository" "main" {
  name = "sandbox-ko-build-app-runner"
}

data "archive_file" "main" {
  type        = "zip"
  source_dir  = "${path.module}/cmd/app"
  output_path = "app.zip"
}

resource "null_resource" "main" {
  triggers = {
    src_hash = data.archive_file.main.output_sha
  }

  provisioner "local-exec" {
    command = "ko build --bare --sbom=none ."

    working_dir = "${path.module}/cmd/app"

    environment = {
      KO_DOCKER_REPO = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${aws_ecr_repository.main.name}"
    }
  }

  depends_on = [data.archive_file.main, aws_ecr_repository.main]
}
