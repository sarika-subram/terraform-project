locals {
  name_prefix = var.environment
}

# Create the ECS cluster
resource "aws_ecs_cluster" "main_cluster" {
  name = "${local.name_prefix}-main-cluster"
}

# Create the ECS task definition
resource "aws_ecs_task_definition" "main_task" {
  family                   = "main-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = file("${path.module}/task-definitions/container-def.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
}

# Create the ECS service
resource "aws_ecs_service" "main_service" {
  name            = "${local.name_prefix}-main-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.main_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = "my-node-app"
    container_port   = 80
  }
}

