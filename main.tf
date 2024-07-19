provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment     = var.environment
      Project         = var.project
      Team = var.team
      CostCentre = var.costcentre
      Owner = var.owner
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
  environment = var.environment
}

module "security_groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
  environment = var.environment
}

module "load_balancer" {
  source           = "./modules/load-balancer"
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnets
  lb_security_group_id = module.security_groups.lb_security_group_id
  environment = var.environment
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.load_balancer.lb_dns_name
}

module "ecs_cluster" {
  source           = "./modules/ecs-cluster"
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  ecs_security_group_id = module.security_groups.ecs_security_group_id
  lb_target_group_arn = module.load_balancer.lb_target_group_arn
  environment = var.environment
}

module "website" {
  source      = "./modules/s3-website"
  bucket_name = "your-bucket-name"
  environment = var.environment
}