resource "aws_ecs_cluster" "this" {
  name = "prefect-cluster"

  service_connect_defaults {
    namespace = aws_service_discovery_private_dns_namespace.this.arn
  }

  tags = {
    Name = "prefect-ecs"
  }
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "default.prefect.local"
  description = "Private DNS namespace for ECS service discovery"
  vpc         = var.vpc_id
}
