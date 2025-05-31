output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.arn
}

output "service_discovery_namespace_id" {
  description = "ID of the service discovery private DNS namespace"
  value       = aws_service_discovery_private_dns_namespace.this.id
}
