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

  # Updated to port 80 to match your Docker mapping
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

resource "aws_instance" "hmsapp_server" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              
              # Run the Database
              sudo docker run -d --name hms-db \
                -e POSTGRES_USER=user \
                -e POSTGRES_PASSWORD='${var.db_password}' \
                -e POSTGRES_DB=hms_db \
                -p 5432:5432 \
                postgres:15

              # Run App (Wait for DB is handled by --restart always)
              sudo docker run -d --name hms-app -p 80:8000 \
                --restart always \
                -e DATABASE_URL="${var.db_url}" \
                -e JWT_KEY="${var.jwt_key}" \
                -e ACCESS_TOKEN_EXPIRES="${var.access_token_expires}" \
                -e GROQ_API_KEY="${var.groq_api_key}" \
                -e MAIL_USERNAME="${var.mail_username}" \
                -e MAIL_PASSWORD="${var.mail_password}" \
                -e MAIL_FROM="${var.mail_from}" \
                -e MAIL_SERVER="${var.mail_server}" \
                -e MAIL_PORT="${var.mail_port}" \
                marcusadigun/hms-app:v14
            EOF
  tags = {
    Name = "HMS-Automated-Server"
  }
}

