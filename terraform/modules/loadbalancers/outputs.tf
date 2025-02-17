output "logic_alb_dns" {
  value = aws_lb.logic_lb.dns_name
}

output "logic_alb_endpoint" {
  value = aws_lb.logic_lb.arn
}

output "logic_lb_tg_name" {
  value = aws_lb_target_group.logic_lb_tg.name
}

output "logic_lb_tg" {
  value = aws_lb_target_group.logic_lb_tg.arn
}

output "presentation_lb_dns" {
  value = aws_lb.presentation_lb.dns_name
}

output "presentation_lb_endpoint" {
  value = aws_lb.presentation_lb.dns_name
}

output "presentation_tg_name" {
  value = aws_lb_target_group.presentation_tg.name
}

output "presentation_tg" {
  value = aws_lb_target_group.presentation_tg.arn
}