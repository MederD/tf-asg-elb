# Subnets to launch
resource "aws_subnet" "sub-public-2a" {
  vpc_id     = aws_vpc.vpc-ohio.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub-public-2a"
  }
}

resource "aws_subnet" "sub-public-2b" {
  vpc_id     = aws_vpc.vpc-ohio.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub-public-2b"
  }
}