output "lb_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.main_lb.arn
}

output "lb_target_group_arn" {
  description = "ARN of the load balancer target group"
  value       = aws_lb_target_group.main_tg.arn
}

output "lb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main_lb.dns_name
}