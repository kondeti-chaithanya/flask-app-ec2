data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}





########################################
# 1. VPC MODULE (Network Layer)
########################################
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

########################################
# 2. SECURITY GROUP (Firewall Rules)
########################################
resource "aws_security_group" "sg" {
  name        = "allow-app"
  description = "Allow SSH and App traffic"
  vpc_id      = module.vpc.vpc_id

  # SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # App access (Flask / Docker)
  ingress {
    description = "App Port"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "allow-app-sg"
    Environment = var.environment
  }
}

########################################
# 3. EC2 MODULE (Compute Layer)
########################################
module "ec2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name

  # 🔗 Dynamic references (NO hardcoding)
  subnet_id          = module.vpc.subnet_id
  security_group_ids = [aws_security_group.sg.id]

  name        = "flask-ec2"
  environment = var.environment

  #  Auto setup (Docker + App)
  user_data = file("${path.module}/user_data.sh")
}