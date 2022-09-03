resource "aws_lb" "main" {
  name               = "lamb-sbx-terraform-ecs"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.allow_http.id,
  ]
  subnets = [
    aws_subnet.main_a.id,
    aws_subnet.main_c.id,
  ]
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "OK"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.main.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

resource "aws_lb_target_group" "main" {
  name        = "lamb-sbx-terraform-ecs"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    port = 80
    path = "/"
  }
}
