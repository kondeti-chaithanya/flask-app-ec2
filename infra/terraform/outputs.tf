output "public_ip" {
  value = aws_instance.docker_app.public_ip
}