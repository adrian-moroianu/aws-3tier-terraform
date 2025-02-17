resource "aws_lb" "presentation_lb" {
  name            = "presentation-lb"
  security_groups = [var.presentation_web_lb_sg]
  subnets         = var.presentation_web_pub_subnets
  idle_timeout    = 300
}

resource "aws_lb_target_group" "presentation_tg" {
  name     = "presentation-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "presentation_listener" {
  load_balancer_arn = aws_lb.presentation_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.presentation_tg.arn
  }
}

resource "aws_lb" "logic_lb" {
  name            = "logic-lb"
  subnets         = var.logic_app_prv_subnets
  security_groups = [var.logic_app_lb_sg]
  idle_timeout    = 300
}

resource "aws_lb_target_group" "logic_lb_tg" {
  name     = "logic-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "logic_lb_listener" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.logic_lb.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.logic_lb_tg.arn
  }
}