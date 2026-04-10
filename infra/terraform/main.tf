resource "aws_instance" "docker_app" {
  ami           = var.ami_id
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user

              docker run -d -p 80:5000 nginx
              EOF

  tags = {
    Name = "docker-ec2-app"
  }
}