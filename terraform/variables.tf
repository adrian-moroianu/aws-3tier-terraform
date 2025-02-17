### AWS Region var ###

variable "region" {
  description = "This variable is for choosing the AWS region"
  type        = string
  default     = "eu-central-1"
}


### Network vars ###

variable "presentation_subnet_count" {
  description = "Public presentation tier subnet count"
}

variable "logic_subnet_count" {
  description = "Private logic tier subnet count"
}

variable "data_subnet_count" {
  description = "Private logic tier subnet count"
}


### Database vars ###

variable "data_rds_db_storage" {
  description = "Database storage volume"
}

variable "data_rds_db_engine_version" {
  description = "Database engine version"
}

variable "data_rds_db_instance_class" {
  description = "Database instance class"
}

variable "data_rds_db_name" {
  description = "Database name"
}

variable "data_rds_db_user" {
  description = "Database username"
  sensitive   = true
}

variable "data_rds_db_password" {
  description = "Database password"
  sensitive   = true
}

variable "data_rds_db_identifier" {
  description = "Database identifier"
}


### Compute vars ###

variable "presentation_instance_type" {
  description = "Instance type for presentation tier"
}

variable "presentation_instance_id" {
  description = "Instance AMI for presentation tier"
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

variable "logic_instance_type" {
  description = "Instance type for logic tier"
}

variable "logic_instance_id" {
  description = "Instance AMI for logic tier"
}

variable "logic_asg_min_size" {
  description = "Minimum size for ASG logic tier"
}

variable "logic_asg_max_size" {
  description = "Maximum size for ASG logic tier"
}

variable "logic_asg_desired_size" {
  description = "Desired size for ASG presentation tier"
}
