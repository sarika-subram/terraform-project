variable "environment" {
  description = "Environment (staging, dev, prod)"
  type        = string
  default = "dev"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnets" {
  description = "IDs of the private subnets"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ID of the ECS security group"
  type        = string
}

variable "lb_target_group_arn" {
  description = "ARN of the load balancer target group"
  type        = string
}