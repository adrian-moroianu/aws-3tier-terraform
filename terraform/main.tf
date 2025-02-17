module "network" {
  source                    = "./modules/network"
  presentation_subnet_count = var.presentation_subnet_count
  logic_subnet_count        = var.logic_subnet_count
  data_subnet_count         = var.data_subnet_count
}

module "database" {
  source                     = "./modules/database"
  data_rds_db_storage        = var.data_rds_db_storage
  data_rds_db_engine_version = var.data_rds_db_engine_version
  data_rds_db_instance_class = var.data_rds_db_instance_class
  data_rds_db_name           = var.data_rds_db_name
  data_rds_db_user           = var.data_rds_db_user
  data_rds_db_password       = var.data_rds_db_password
  data_rds_db_identifier     = var.data_rds_db_identifier
  data_rds_db_subnet_group   = module.network.data_rds_db_subnet_group[0]
  data_rds_db_sg             = module.network.data_rds_db_sg
}

module "loadbalancer" {
  source                       = "./modules/loadbalancers"
  presentation_web_lb_sg       = module.network.presentation_web_lb_sg
  logic_app_lb_sg              = module.network.logic_app_lb_sg
  vpc_id                       = module.network.vpc_id
  presentation_web_pub_subnets = module.network.presentation_web_pub_subnets
  logic_app_prv_subnets        = module.network.logic_app_prv_subnets
  depends_on                   = [module.network]
}

module "compute" {
  source                        = "./modules/compute"
  presentation_web_sg           = module.network.presentation_web_sg
  logic_app_sg                  = module.network.logic_app_sg
  presentation_tg               = module.loadbalancer.presentation_tg
  presentation_tg_name          = module.loadbalancer.presentation_tg_name
  logic_lb_tg                   = module.loadbalancer.logic_lb_tg
  logic_app_prv_subnets         = module.network.logic_app_prv_subnets
  presentation_web_pub_subnets  = module.network.presentation_web_pub_subnets
  presentation_instance_type    = var.presentation_instance_type
  presentation_instance_id      = var.presentation_instance_id
  presentation_asg_min_size     = var.presentation_asg_min_size
  presentation_asg_max_size     = var.presentation_asg_max_size
  presentation_asg_desired_size = var.presentation_asg_desired_size
  logic_instance_type           = var.logic_instance_type
  logic_instance_id             = var.logic_instance_id
  logic_asg_min_size            = var.logic_asg_min_size
  logic_asg_max_size            = var.logic_asg_max_size
  logic_asg_desired_size        = var.logic_asg_desired_size
}