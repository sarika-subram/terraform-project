variable "environment" {
  description = "Environment (staging, dev, prod)"
  type        = string
  default = "dev"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for website hosting"
  type        = string
  default = "a-totally-unique-bucket-name"
}