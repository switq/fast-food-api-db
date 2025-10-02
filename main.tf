# 1. VPC existente (default)
data "aws_vpc" "default" {
  default = true
}

# 2. Security Group para o RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow DB access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Subnet Group usando subnets já existentes
resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = [
    "subnet-044698579c1172179", # us-east-1e
    "subnet-02e1067f075f0cd76", # us-east-1d
    # você pode adicionar a da us-east-1a também se quiser
  ]
  tags = {
    Name = "default-rds-subnet-group"
  }
}

# 4. Instância RDS
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
  multi_az               = false
  publicly_accessible    = false
}
