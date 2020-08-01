#VPC launching
resource "aws_vpc" "vpc-ohio" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-ohio"
  }
}

# Route table
resource "aws_route_table" "rt-ohio-pub" {
  vpc_id = aws_vpc.vpc-ohio.id  
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = {
    Name = "rt-ohio-pub"
  } 
}

# Route table association
resource "aws_route_table_association" "route_assoc_2a" {
  subnet_id      = aws_subnet.sub-public-2a.id
  route_table_id = aws_route_table.rt-ohio-pub.id
}

resource "aws_route_table_association" "route_assoc_2b" {
  subnet_id      = aws_subnet.sub-public-2b.id
  route_table_id = aws_route_table.rt-ohio-pub.id
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-ohio.id

  tags = {
    Name = "igw-ohio"
  }
}