output "app_url" {
  description = "Public URL of the application"
  value       = "http://${module.ecs.alb_dns_name}"
}

output "ecr_repository_url" {
  description = "URL of ECR repository"
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "Name of ECS cluster"
  value       = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
  description = "Name of ECS service"
  value       = module.ecs.ecs_service_name
}

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
}