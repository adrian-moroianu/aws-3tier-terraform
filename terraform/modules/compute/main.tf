resource "aws_launch_template" "presentation_tier_instance" {
  name_prefix            = "presentation_tier_instance"
  instance_type          = var.presentation_instance_type
  image_id               = var.presentation_instance_id
  vpc_security_group_ids = [var.presentation_web_sg]
  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Welcome to Web Server</h1>" | sudo tee /var/www/html/index.html
              EOF
  )
}

resource "aws_autoscaling_group" "presentation_tier_asg" {
  name                = "presentation_tier_asg"
  vpc_zone_identifier = var.presentation_web_pub_subnets
  min_size            = var.presentation_asg_min_size
  max_size            = var.presentation_asg_max_size
  desired_capacity    = var.presentation_asg_desired_size
  launch_template {
    id      = aws_launch_template.presentation_tier_instance.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "presentation_asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.presentation_tier_asg.id
  lb_target_group_arn    = var.presentation_tg
}

resource "aws_launch_template" "logic_tier_instance" {
  name_prefix            = "logic_tier_instance"
  instance_type          = var.logic_instance_type
  image_id               = var.logic_instance_id
  vpc_security_group_ids = [var.logic_app_sg]
}

resource "aws_autoscaling_group" "logic_tier_asg" {
  name                = "logic_tier_asg"
  vpc_zone_identifier = var.logic_app_prv_subnets
  min_size            = var.logic_asg_min_size
  max_size            = var.logic_asg_max_size
  desired_capacity    = var.logic_asg_desired_size
  launch_template {
    id      = aws_launch_template.logic_tier_instance.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "logic_asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.logic_tier_asg.id
  lb_target_group_arn    = var.logic_lb_tg
}
