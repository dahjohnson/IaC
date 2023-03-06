################################################################################
# VPC
################################################################################

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.env}-vpc"
    Environment = var.env
  }
}

################################################################################
# Public and Private Subnets
################################################################################

data "aws_availability_zones" "az" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_block[count.index]
  availability_zone       = data.aws_availability_zones.az.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = join("-", ["${var.env}-public-subnet", data.aws_availability_zones.az.names[count.index]])
    Environment = var.env
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr_block[count.index]
  availability_zone = data.aws_availability_zones.az.names[count.index]

  tags = {
    Name        = join("-", ["${var.env}-private-subnet", data.aws_availability_zones.az.names[count.index]])
    Environment = var.env
  }
}

################################################################################
# Internet and NAT Gateway
################################################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.env}-internet-gw"
    Environment = var.env
  }
}

resource "aws_eip" "elastic_ip" {
  count = 2

  tags = {
    Name        = "${var.env}-elastic-ip"
    Environment = var.env
  }
}

resource "aws_nat_gateway" "ngw" {
  count             = 2
  allocation_id     = aws_eip.elastic_ip[count.index].id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet[count.index].id

  tags = {
    Name        = "${var.env}-nat-gw"
    Environment = var.env
  }
}

################################################################################
# Route Tables
################################################################################

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.env}-public-route-table"
    Environment = var.env
  }
}

resource "aws_route_table" "private_route_table" {
  count  = 2
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[count.index].id
  }

  tags = {
    Name        = "${var.env}-private-route-table"
    Environment = var.env
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}