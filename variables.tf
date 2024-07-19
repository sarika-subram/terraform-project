variable "aws_region" {
  description = "AWS region to create resources in"
  type = string
  default = "us-east-1"
}

variable "environment" {
  description = "Environment (staging, dev, prod)"
  type        = string
  default = "dev"
}

variable "project" {
  description = "Project or application to which this resource belongs"
  type        = string
  default = "my-project"
}

variable "team" {
  description = "Team or department responsible for managing the resource"
  type        = string
  default = "my-team"
}

variable "costcentre" {
  description = "Team or department responsible for managing the resource"
  type        = string
  default = "my-costcentre"
}

variable "owner" {
  description = "Individual or team responsible for the resource"
  type        = string
  default = "ceo"
}