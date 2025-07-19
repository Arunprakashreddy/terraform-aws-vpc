#vpc creation
resource "aws_vpc" "chandu_vpc" {
  cidr_block = var.aws_vpc_cidr_block
}

#internet Gateway
resource "aws_internet_gateway" "chandu_ig_gateway" {
  vpc_id = aws_vpc.chandu_vpc.id
}

#public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.chandu_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.public_az
  map_public_ip_on_launch = true
}

#private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.chandu_vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.private_az
  map_public_ip_on_launch = false
}

#public route table
resource "aws_route_table" "public_routes" {
  vpc_id = aws_vpc.chandu_vpc.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.chandu_ig_gateway.id
  }
}

#private route table
resource "aws_route_table" "private_routes" {
  vpc_id = aws_vpc.chandu_vpc.id

  route {
    cidr_block = var.private_route_cidr_block
  }
}

#public route table association
resource "aws_route_table_association" "public_route_association" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_routes.id
  gateway_id = aws_internet_gateway.chandu_ig_gateway.id
}

#private routes table association
resource "aws_route_table_association" "private_route_association" {
  subnet_id = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private_routes.id
}