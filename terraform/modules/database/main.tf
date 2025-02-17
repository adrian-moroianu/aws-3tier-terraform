resource "aws_db_instance" "data_db" {
  allocated_storage      = var.data_rds_db_storage
  engine                 = "mysql"
  engine_version         = var.data_rds_db_engine_version #"8.0"
  instance_class         = var.data_rds_db_instance_class
  db_name                = var.data_rds_db_name
  username               = var.data_rds_db_user
  password               = var.data_rds_db_password
  identifier             = var.data_rds_db_identifier
  skip_final_snapshot    = true
  db_subnet_group_name   = var.data_rds_db_subnet_group
  vpc_security_group_ids = [var.data_rds_db_sg]
}