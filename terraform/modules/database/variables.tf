variable "data_rds_db_engine_version" {
  description = "Database rds engine version"
}

variable "data_rds_db_identifier" {
  description = "Database rds identifier"
}

variable "data_rds_db_instance_class" {
  description = "Database rds instance class"
}

variable "data_rds_db_subnet_group" {
  description = "Database rds subnet group"
}

variable "data_rds_db_sg" {
  description = "Database rds security group"
}

variable "data_rds_db_password" {
  description = "Database rds password"
  sensitive   = true
}

variable "data_rds_db_user" {
  description = "Database rds username"
}

variable "data_rds_db_name" {
  description = "Database rds name"
}

variable "data_rds_db_storage" {
  description = "Database rds storage volume"
}
