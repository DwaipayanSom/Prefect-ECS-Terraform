output "prefect_api_secret_arn" {
  description = "ARN of the Prefect API key secret"
  value       = aws_secretsmanager_secret.prefect_api_key.arn
}
