# vpc_setup.tf

# Create VPC
resource "aws_vpc" "main" {
  cidr_block          = var.vpc_cidr_block
  enable_dns_support  = true
  enable_dns_hostnames = true

  tags = {
    Name = "LightFeatherVPC"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "LightFeatherIGW"
  }
}

# Create Subnet1 and associate with Route Table
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr_block
  availability_zone = var.availability_zone1

  # Specify the attribute directly
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet1"
  }
}

# Create Route Table for Subnet1
resource "aws_route_table" "subnet1_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Associate Subnet1 with Route Table1
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.subnet1_route_table.id
}

# Create Subnet2 and associate with Route Table
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr_block
  availability_zone = var.availability_zone2
}

# Create Route Table for Subnet2
resource "aws_route_table" "subnet2_route_table" {
  vpc_id = aws_vpc.main.id
}

# Associate Subnet2 with Route Table2
resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.subnet2_route_table.id
}
