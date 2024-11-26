resource "aws_instance" "this" {
  ami                     = "ami-0453ec754f44f9a4a"
  instance_type           = "t2.micro"
  key_name                = "ansible"
  subnet_id               = data.aws_subnets.public_subnets.ids[0]
  security_groups = [aws_security_group.sg.id]
  associate_public_ip_address = true
  user_data = base64encode(templatefile("${path.module}/templates/user_data.tpl", {
    ansible_user_password = var.ansible_user_password
  }))
}

resource "aws_security_group" "sg" {
  name        = "${lower(var.environment)}-ansible-master-sg"
  description = "Security group for EC2 Instances"
  vpc_id      = var.vpc_id
  # Ingress rule to allow traffic within the VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                        # Allows all protocols
    cidr_blocks = [data.aws_vpc.selected.cidr_block] # VPC CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-${var.environment}"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"] # This matches all subnets with a Name tag
  }
}