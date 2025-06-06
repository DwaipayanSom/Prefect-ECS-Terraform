output "ecs_service_name" {
  value = aws_ecs_service.prefect_worker_service.name
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.prefect_worker.arn
}
