variable "environment" {
  description = "Environment name (dev, stg, prd, hfx)"
  type        = string
}

variable "project" {
  description = "Project name for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EC2 will be launched"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_name" {
  description = "AMI name filter (e.g. al2023-ami-2023.10.02.20260202-kernel-default-x86_64)"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}

variable "ssh_allowed_cidrs" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
