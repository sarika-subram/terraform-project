variable "environment" {
  description = "Environment (staging, dev, prod)"
  type        = string
  default = "dev"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "IDs of the public subnets"
  type        = list(string)
}

variable "lb_security_group_id" {
  description = "ID of the load balancer security group"
  type        = string
}