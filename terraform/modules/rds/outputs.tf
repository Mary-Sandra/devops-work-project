output "db_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.main.endpoint
}

output "db_name" {
  description = "Name of the database"
  value       = aws_db_instance.main.db_name
}

output "database_url" {
  description = "Full database connection URL for the application"
  value       = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.main.endpoint}/${var.db_name}"
  sensitive   = true
}