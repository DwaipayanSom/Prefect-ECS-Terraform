resource "aws_ecs_task_definition" "prefect_worker" {
  family                   = "prefect-dev-worker"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "512"
  memory                  = "1024"
  execution_role_arn      = var.execution_role_arn
  task_role_arn           = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name  = "prefect-worker"
      image = "prefecthq/prefect:2-latest"
      essential = true
      environment = [
        {
          name  = "PREFECT_API_URL"
          value = var.prefect_api_url
        },
        {
          name  = "PREFECT_ACCOUNT_ID"
          value = var.prefect_account_id
        },
        {
          name  = "PREFECT_WORKSPACE_ID"
          value = var.prefect_workspace_id
        },
        {
          name  = "PREFECT_WORK_POOL_NAME"
          value = var.prefect_work_pool_name
        }
      ]
      secrets = [
        {
          name      = "PREFECT_API_KEY"
          valueFrom = var.prefect_api_key_secret_arn
        }
      ]
      command = ["prefect", "worker", "start", "--pool", var.prefect_work_pool_name]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/prefect"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "prefect_worker_service" {
  name            = "prefect-dev-worker-service"
  cluster         = var.cluster_arn
  launch_type     = "FARGATE"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.prefect_worker.arn

  network_configuration {
    subnets         = var.private_subnet_ids
    assign_public_ip = false
    security_groups = [var.security_group_id]
  }

  service_registries {
    registry_arn = var.service_discovery_arn
  }

  depends_on = [aws_ecs_task_definition.prefect_worker]
}
