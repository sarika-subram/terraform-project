output "lb_security_group_id" {
  description = "ID of the load balancer security group"
  value       = aws_security_group.lb_sg.id
}

output "ecs_security_group_id" {
  description = "ID of the ECS security group"
  value       = aws_security_group.ecs_sg.id
}