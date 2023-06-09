resource "aws_apprunner_service" "main" {
  service_name = "sandbox-ko-build-app-runner"

  instance_configuration {
    cpu               = 1024
    memory            = 2048
    instance_role_arn = aws_iam_role.apprunner_instance_role.arn
  }

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner_access_role.arn
    }
    image_repository {
      image_configuration {
        port = "8080"

        runtime_environment_variables = {}
      }
      image_identifier      = "${aws_ecr_repository.main.repository_url}:latest"
      image_repository_type = "ECR"
    }
  }

  health_check_configuration {
    protocol = "HTTP"
    path     = "/"
  }

  observability_configuration {
    observability_configuration_arn = aws_apprunner_observability_configuration.main.arn
    observability_enabled           = true
  }

  depends_on = [aws_ecr_repository.main, null_resource.main]
}

resource "aws_apprunner_observability_configuration" "main" {
  observability_configuration_name = "sandbox-ko-build-app-runner"

  trace_configuration {
    vendor = "AWSXRAY"
  }
}

output "app_url" {
  value = aws_apprunner_service.main.service_url
}
