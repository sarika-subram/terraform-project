output "website_endpoint" {
  description = "Endpoint for the website"
  value       = aws_s3_bucket_website_configuration.website_config.website_endpoint
}