variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of public subnets for ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs of private subnets for ECS tasks"
  type        = list(string)
}

variable "ecr_repository_url" {
  description = "URL of ECR repository"
  type        = string
}

variable "task_execution_role_arn" {
  description = "ARN of ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of ECS task role"
  type        = string
}

variable "database_url" {
  description = "Full database connection URL"
  type        = string
  sensitive   = true
}

variable "alb_security_group_id" {
  description = "ID of ALB security group"
  type        = string
}

variable "ecs_security_group_id" {
  description = "ID of ECS security group"
  type        = string
}