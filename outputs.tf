output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of public subnets"
  value       = module.vpc.public_subnet_cidrs
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "EC2 public IP address"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "EC2 public DNS name"
  value       = module.ec2.public_dns
}

output "ec2_private_ip" {
  description = "EC2 private IP address"
  value       = module.ec2.private_ip
}

output "cloudfront_domain" {
  description = "CloudFront distribution domain"
  value       = module.cloudfront.domain_name
}

output "cloudfront_url" {
  description = "CloudFront URL (HTTPS)"
  value       = module.cloudfront.url
}
