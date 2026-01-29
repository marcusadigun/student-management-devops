provider "aws" {
  region = "us-east-1"
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
    from_port   = 8000
    to_port     = 8000
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


resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04
  instance_type = "t3.micro"


  key_name = aws_key_pair.deployer_key.key_name

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "HMS-Production-Server"
  }
}

output "ssh_command" {
  value = "ssh -i hms-key.pem ubuntu@${aws_instance.app_server.public_ip}"
}
