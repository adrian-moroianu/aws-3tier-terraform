variable "presentation_instance_type" {
  description = "Instance type for presentation tier"
}

variable "presentation_instance_id" {
  description = "Instance AMI for presentation tier"
}

variable "presentation_web_sg" {
  description = "Presentation web tier security group"
}

variable "presentation_asg_min_size" {
  description = "Minimum size for ASG presentation tier"
}

variable "presentation_asg_max_size" {
  description = "Maximum size for ASG presentation tier"
}

variable "presentation_asg_desired_size" {
  description = "Desired size for ASG presentation tier"
}

variable "presentation_tg" {
  description = "Presentation tier target group"
}

variable "logic_instance_type" {
  description = "Instance type for logic tier"
}

variable "logic_instance_id" {
  description = "Instance AMI for logic tier"
}

variable "logic_app_sg" {
  description = "Logic app tier security group"
}

variable "logic_app_prv_subnets" {
  description = "Logic app tier private subnets"
}

variable "logic_asg_min_size" {
  description = "Logic tier asg minimum instance size"
}

variable "logic_asg_max_size" {
  description = "Logic tier asg maximum instance size"
}

variable "logic_asg_desired_size" {
  description = "Logic tier asg desired instance size"
}

variable "logic_lb_tg" {
  description = "Logic tier loadbalacer desired instance size"
}

variable "presentation_web_pub_subnets" {
  description = "Presentation web tier public subnets"
}

variable "presentation_tg_name" {
  description = "Presentation tier target group name"
}