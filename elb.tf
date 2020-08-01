# application launch balancer SG
resource "aws_security_group" "elb_http" {
  name        = "elb_http"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id = aws_vpc.vpc-ohio.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP through ELB Security Group"
  }
}
# ELB
resource "aws_elb" "elb" {
  name               = "elb"
  security_groups    = [aws_security_group.elb_http.id]
 # availability_zones = ["${data.aws_availability_zones.all.names}"]
  subnets             = [aws_subnet.sub-public-2a.id, 
                        aws_subnet.sub-public-2b.id]

  # will work on this later
  # health_check {
  #   healthy_threshold = 5
  #   unhealthy_threshold = 5
  #   timeout = 3
  #   interval = 30
  #   target = "HTTP:80/"
  # }

  # This adds a listener for incoming HTTP requests.
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}
