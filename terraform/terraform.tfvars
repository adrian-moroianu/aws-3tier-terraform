### AWS Region ###
region = "eu-central-1"

#### Network variables ###
presentation_subnet_count = "2"
logic_subnet_count        = "2"
data_subnet_count         = "2"

### Database variables ###
data_rds_db_storage        = "5"
data_rds_db_engine_version = "8.0"
data_rds_db_instance_class = "db.t3.micro"
data_rds_db_name           = "dataRDSdb"
data_rds_db_user           = "user1000"
data_rds_db_password       = "password1234"
data_rds_db_identifier     = "datardsdb"

### Compute variables ###
presentation_instance_type    = "t2.micro"
presentation_instance_id      = "ami-0c8db01b2e8e5298d"
presentation_asg_min_size     = "2"
presentation_asg_max_size     = "2"
presentation_asg_desired_size = "2"
logic_instance_type           = "t2.micro"
logic_instance_id             = "ami-0c8db01b2e8e5298d"
logic_asg_min_size            = "2"
logic_asg_max_size            = "2"
logic_asg_desired_size        = "2"