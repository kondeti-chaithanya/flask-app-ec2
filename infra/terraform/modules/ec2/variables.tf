variable "ami" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair"
  type        = string
}

variable "security_group_ids" {
  description = "Security groups"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "user_data" {
  description = "Startup script"
  type        = string
}

variable "name" {
  description = "Instance name"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}