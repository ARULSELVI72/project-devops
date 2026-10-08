resource "aws_security_group" "ec2_sg" {
  name   = "devops-ec2-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-ec2-sg"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-065d2b03fb493085a"
  instance_type = "t3.micro"

  key_name = "test"

  subnet_id = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "devops-app-server"
  }
}

output "ec2_instance_id" {
  value = aws_instance.app_server.id
}

output "ec2_public_ip" {
  value = aws_instance.app_server.public_ip
}