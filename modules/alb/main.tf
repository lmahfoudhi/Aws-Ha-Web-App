resource "aws_alb" "application_load_balancer" {
  name               = "${var.environment}-${var.id}-alb"
  internal           = false
  load_balancer_type = "application"

  subnets         = var.alb_subnets
  security_groups = var.security_group_ids

  tags = {
      Name        = "${var.environment}-${var.id}-alb",
      Environment = var.environment,
      id = var.id
    }
}

resource "aws_alb_target_group" "alb_tg" {
  name_prefix = "alb-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    port                = 8080
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  load_balancing_algorithm_type = "round_robin"
  tags = {
      Name        = "${var.environment}-${var.id}-alb-tg"
      Environment = var.environment,
      id = var.id
    }
}

resource "aws_alb_listener" "application_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    type             = "forward"
  }
}
