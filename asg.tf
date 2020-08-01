provider "aws" {
  profile = "default"
  version = "~> 2.70"
  region  = "us-east-2"
}

# Instance launch template
resource "aws_launch_template" "launch" {
  name   = "launch-template"
  image_id      = "ami-07c8bc5c1ce9598c3"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  key_name      = "ubuntu_keygen"
  
  vpc_security_group_ids = [aws_security_group.secgroup-pub.id]
  
  lifecycle {
    create_before_destroy = true
  }
}

# Auto scaling group
resource "aws_autoscaling_group" "asg-group" {
  
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  #availability_zones = ["us-east-2a", "us-east-2b"]
  vpc_zone_identifier = [aws_subnet.sub-public-2a.id, 
                        aws_subnet.sub-public-2b.id]

  health_check_type    = "ELB"
  load_balancers= [aws_elb.elb.name]

  launch_template {
    id      = aws_launch_template.launch.id
    version = "$Latest"
  }

lifecycle {
    create_before_destroy = true
  }
}