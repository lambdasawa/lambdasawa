resource "aws_ecs_cluster" "main" {
  name = "lamb-sbx-terraform-ecs"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "main"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name      = "web"
      image     = "nginx:latest"
      essential = true
      cpu       = 128
      memory    = 256
      portMappings = [
        {
          containerPort = 80
        }
      ]
    },
  ])
}

resource "aws_ecs_service" "main" {
  name            = "web"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.main_a.id,
      aws_subnet.main_c.id,
    ]
    security_groups = [
      aws_security_group.allow_http.id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.id
    container_name   = "web"
    container_port   = 80
  }
}
