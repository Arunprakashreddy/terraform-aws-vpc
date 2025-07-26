#vpc creation
resource "aws_vpc" "chandu_vpc" {
  cidr_block = var.aws_vpc_cidr_block

  tags = {
    name = "chandu-vpc"
  }
}

#internet Gateway
resource "aws_internet_gateway" "chandu_ig_gateway" {
  vpc_id = aws_vpc.chandu_vpc.id

  tags = {
    name = "chandu-igw"
  }
}

#public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.chandu_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.public_az
  map_public_ip_on_launch = true

  tags = {
    name = "public-sub"
  }
}

#private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.chandu_vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.private_az
  map_public_ip_on_launch = false

  tags = {
    name = "private-sub"
  }
}

#elastic ip (eip)
resource "aws_eip" "chandu-eip" {
  domain = "vpc"
}

#NAT gatway
resource "aws_nat_gateway" "chandu_nat_gateway" {
  allocation_id = aws_eip.chandu-eip.id
  subnet_id = aws_subnet.private-subnet.id

  depends_on = [ aws_internet_gateway.chandu_ig_gateway ]
}

#public route table
resource "aws_route_table" "public_routes" {
  vpc_id = aws_vpc.chandu_vpc.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.chandu_ig_gateway.id
  }

  tags = {
    name = "public-route"
  }
}

#private route table
resource "aws_route_table" "private_routes" {
  vpc_id = aws_vpc.chandu_vpc.id

  route {
    cidr_block = var.private_route_cidr_block
    nat_gateway_id = aws_nat_gateway.chandu_nat_gateway.id
  }

  tags = {
    name = "private-route"
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