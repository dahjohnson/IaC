################################################################################
# Security Group
################################################################################

resource "aws_security_group" "db_security_group" {
  name        = "${var.env}-db-security-group"
  description = "Security Group for RDS instance"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "MySQL traffic from Web Servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.env}-db-security-group"
    Environment = var.env
  }
}

################################################################################
# DB Subnet Group
################################################################################

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = [for i in aws_subnet.private_subnet[*] : i.id]

  tags = {
    Name        = "${var.env}-db-subnet-group"
    Environment = var.env
  }
}

################################################################################
# RDS
################################################################################

resource "aws_db_instance" "db_instance" {
  allocated_storage      = var.db_allocated_storage
  db_name                = var.db_name
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  tags = {
    Name        = "${var.env}-db-instance"
    Environment = var.env
  }
}