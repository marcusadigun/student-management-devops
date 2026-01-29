provider "aws" {
  region = var.aws_region
}

resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  content         = tls_private_key.generated_key.private_key_pem
  filename        = "${path.module}/hms-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "hms-terraform-key"
  public_key = tls_private_key.generated_key.public_key_openssh
}

resource "aws_security_group" "app_sg" {
  name        = "hms-security-group-auto"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- 1. THE APP SERVER ---
resource "aws_instance" "hmsapp_server" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "HMS-Automated-Server"
  }
}

# --- 2. THE DATABASE INFRASTRUCTURE ---

resource "aws_security_group" "rds_sg" {
  name        = "hms-rds-sg"
  description = "Allow traffic from the App Server"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "hms_db" {
  allocated_storage      = 20
  db_name                = "hms_db"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  username               = "hms_admin"
  password               = var.db_password
  parameter_group_name   = "default.postgres16"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "HMS-Production-DB"
  }
}
