resource "aws_secretsmanager_secret" "prefect_api_key" {
  name        = var.secret_name
  description = "Prefect Cloud API Key for ECS worker"
  tags = {
    Name = "prefect-ecs"
  }
}

resource "aws_secretsmanager_secret_version" "prefect_api_key_value" {
  secret_id     = aws_secretsmanager_secret.prefect_api_key.id
  secret_string = jsonencode({
    PREFECT_API_KEY = var.prefect_api_key
  })
}
