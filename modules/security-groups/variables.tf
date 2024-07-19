variable "environment" {
  description = "Environment (staging, dev, prod)"
  type        = string
  default = "dev"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}