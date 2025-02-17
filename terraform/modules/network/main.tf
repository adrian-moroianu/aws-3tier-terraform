### VPC ###
resource "aws_vpc" "vpc_3_tier" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "3-Tier-Architecture-VPC"
  }
}

data "aws_availability_zones" "available_azs" {
}

################## Presentation tier ##################


### create the igw, nat-gw and eip ###
resource "aws_internet_gateway" "presentation_internet_gateway" {
  vpc_id = aws_vpc.vpc_3_tier.id
}

resource "aws_eip" "presentation_elastic_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.presentation_elastic_ip.id
  subnet_id     = aws_subnet.presentation_pub_subnet[0].id
}

### create public subnet ###
resource "aws_subnet" "presentation_pub_subnet" {
  count                   = var.presentation_subnet_count
  vpc_id                  = aws_vpc.vpc_3_tier.id
  cidr_block              = "10.0.${10 + count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]
}

### create the route table ### 
resource "aws_route_table" "presentation_pub_rt" {
  vpc_id = aws_vpc.vpc_3_tier.id
}

resource "aws_route" "presentation_def_public_route" {
  route_table_id         = aws_route_table.presentation_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.presentation_internet_gateway.id
}

resource "aws_route_table_association" "presentation_rt_asc" {
  count          = 2
  route_table_id = aws_route_table.presentation_pub_rt.id
  subnet_id      = aws_subnet.presentation_pub_subnet.*.id[count.index]
}

### loadbalancer security group ###
resource "aws_security_group" "presentation_lb_sg" {
  name   = "presentation_lb_sg"
  vpc_id = aws_vpc.vpc_3_tier.id
  egress {
    protocol    = "-1"
    to_port     = 0
    from_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    to_port     = 80
    from_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    to_port     = 22
    from_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### asg security group ###
resource "aws_security_group" "presentation_sg" {
  vpc_id = aws_vpc.vpc_3_tier.id
  name   = "presentation_sg"
  egress {
    protocol    = "-1"
    to_port     = 0
    from_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_lb_sg.id]
  }
  ingress {
    to_port         = 22
    from_port       = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_lb_sg.id]
  }
}


################## Logic Tier ##################


### create private subnets ###
resource "aws_subnet" "logic_prv_subnet" {
  count                   = var.logic_subnet_count
  vpc_id                  = aws_vpc.vpc_3_tier.id
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]
  cidr_block              = "10.0.${20 + count.index}.0/24"
  map_public_ip_on_launch = false
}

### create the route table ### 
resource "aws_route_table" "logic_prv_rt" {
  vpc_id = aws_vpc.vpc_3_tier.id
}

resource "aws_route" "logic_def_pr_route" {
  route_table_id         = aws_route_table.logic_prv_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "logic_rt_asc" {
  count          = 2
  route_table_id = aws_route_table.logic_prv_rt.id
  subnet_id      = aws_subnet.logic_prv_subnet.*.id[count.index]
}

### loadbalancer security group ###
resource "aws_security_group" "logic_lb_sg" {
  vpc_id = aws_vpc.vpc_3_tier.id
  name   = "logic_lb_sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_lb_sg.id]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.presentation_lb_sg.id]
  }

}

resource "aws_security_group" "logic_sg" {
  name   = "logic_sg"
  vpc_id = aws_vpc.vpc_3_tier.id
  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.logic_lb_sg.id]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.logic_lb_sg.id]
  }
}


################## Data Tier ##################


### create private subnets ###
resource "aws_subnet" "data_prv_subnet" {
  count                   = var.data_subnet_count
  vpc_id                  = aws_vpc.vpc_3_tier.id
  cidr_block              = "10.0.${30 + count.index}.0/24"
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]
}

resource "aws_route_table" "data_prv_sn_rt" {
  vpc_id = aws_vpc.vpc_3_tier.id
}

resource "aws_route" "data_def_pr_route" {
  route_table_id         = aws_route_table.data_prv_sn_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "data_prv_sn_asc" {
  count          = 2
  route_table_id = aws_route_table.data_prv_sn_rt.id
  subnet_id      = aws_subnet.data_prv_subnet.*.id[count.index]
}

### database security group ###
resource "aws_security_group" "data_sg" {
  name   = "data_sg"
  vpc_id = aws_vpc.vpc_3_tier.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    to_port         = 3306
    from_port       = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.logic_sg.id]
  }
}

### create the database subnet group ###
resource "aws_db_subnet_group" "data_subnet_group" {
  name       = "data_subnet_group"
  subnet_ids = [aws_subnet.data_prv_subnet[0].id, aws_subnet.data_prv_subnet[1].id]
}