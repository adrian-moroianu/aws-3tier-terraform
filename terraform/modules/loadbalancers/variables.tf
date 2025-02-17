variable "presentation_web_lb_sg" {
  description = "Presentation web tier loadbalancer security group"
}

variable "presentation_web_pub_subnets" {
  description = "Presentation web tier public sunets"
}

variable "logic_app_prv_subnets" {
  description = "Logic app tier private sunets"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "logic_app_lb_sg" {
  description = "Logic app tier loadbalancer security group"
}
