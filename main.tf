module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source = "./modules/ecs"
  vpc_id = module.vpc.vpc_id
}

module "secrets" {
  source          = "./modules/secrets"
  prefect_api_key = var.prefect_api_key
}

module "worker" {
  source = "./modules/worker"

  execution_role_arn         = module.iam.ecs_task_execution_role_arn
  cluster_arn                = module.ecs.ecs_cluster_arn
  service_discovery_arn      = module.ecs.service_discovery_namespace_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  security_group_id          = module.vpc.worker_sg_id

  prefect_api_key_secret_arn = module.secrets.prefect_api_secret_arn
  prefect_api_url            = var.prefect_api_url
  prefect_account_id         = var.prefect_account_id
  prefect_workspace_id       = var.prefect_workspace_id
  prefect_work_pool_name     = var.prefect_work_pool_name
  aws_region                 = var.aws_region
}
