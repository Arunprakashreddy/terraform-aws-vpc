#vpc creation
resource "aws_vpc" "global_vpc" {
  cidr_block = var.aws_vpc_cidr_block

  tags = {
    Name = var.aws_vpc_name
  }
}

#internet Gateway
resource "aws_internet_gateway" "global_igw_gateway" {
  vpc_id = aws_vpc.global_vpc.id

  tags = {
    Name = var.aws_igw_name
  }
}

#public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.global_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.public_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.aws_public_subnet_name
  }
}

#private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.global_vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.private_az
  map_public_ip_on_launch = false

  tags = {
    Name = var.aws_private_subnet_name
  }
}

#NAT gatway
resource "aws_nat_gateway" "global_nat_gateway" {
  allocation_id = var.aws_eip_id
  subnet_id = aws_subnet.public-subnet.id

  depends_on = [ aws_internet_gateway.global_igw_gateway ]
}

#public route table
resource "aws_route_table" "public_routes" {
  vpc_id = aws_vpc.global_vpc.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.global_igw_gateway.id
  }

  tags = {
    Name = "public-route"
  }
}

#private route table
resource "aws_route_table" "private_routes" {
  vpc_id = aws_vpc.global_vpc.id

  route {
    cidr_block = var.private_route_cidr_block
    nat_gateway_id = aws_nat_gateway.global_nat_gateway.id
  }

  tags = {
    Name = "private-route"
  }
}

#public route table association
resource "aws_route_table_association" "public_route_association" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_routes.id
}

#private routes table association
resource "aws_route_table_association" "private_route_association" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private_routes.id
}