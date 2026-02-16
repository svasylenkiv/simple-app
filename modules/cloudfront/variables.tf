variable "project" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, stg, prd, hfx)"
  type        = string
}

variable "origin_domain" {
  description = "Origin domain (EC2 public DNS)"
  type        = string
}

variable "price_class" {
  description = "CloudFront price class (PriceClass_All, PriceClass_200, PriceClass_100)"
  type        = string
  default     = "PriceClass_100"
}
