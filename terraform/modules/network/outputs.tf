output "vpc_id" {
  value = aws_vpc.vpc_3_tier.id
}

output "data_db_subnet_group_name" {
  value = aws_db_subnet_group.data_subnet_group.*.name
}

output "data_rds_db_subnet_group" {
  value = aws_db_subnet_group.data_subnet_group.*.id
}

output "data_rds_db_sg" {
  value = aws_security_group.data_sg.id
}

output "presentation_web_sg" {
  value = aws_security_group.presentation_sg.id
}

output "presentation_web_lb_sg" {
  value = aws_security_group.presentation_lb_sg.id
}

output "logic_app_sg" {
  value = aws_security_group.logic_sg.id
}

output "logic_app_lb_sg" {
  value = aws_security_group.logic_lb_sg.id
}

output "presentation_web_pub_subnets" {
  value = aws_subnet.presentation_pub_subnet.*.id
}

output "logic_app_prv_subnets" {
  value = aws_subnet.logic_prv_subnet.*.id
}

output "data_db_prv_subnets" {
  value = aws_subnet.data_prv_subnet.*.id
}