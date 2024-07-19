locals {
  name_prefix = var.environment
}

# Create the load balancer
resource "aws_lb" "main_lb" {
  name               = "${local.name_prefix}-main-lb"
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [var.lb_security_group_id]
}

# Create the target group for the load balancer
resource "aws_lb_target_group" "main_tg" {
  name        = "main-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

# Create the listener for the load balancer
resource "aws_lb_listener" "main_listener" {
  load_balancer_arn = aws_lb.main_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_tg.arn
  }
}