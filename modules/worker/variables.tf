variable "execution_role_arn" {
  description = "IAM Role for ECS task execution"
  type        = string
}

variable "cluster_arn" {
  description = "ECS cluster ARN"
  type        = string
}

variable "service_discovery_arn" {
  description = "ARN of the private DNS namespace"
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnets for Fargate service"
}

variable "security_group_id" {
  type        = string
  description = "Security group for the Fargate task"
}

variable "prefect_api_key_secret_arn" {
  type        = string
  description = "ARN of the AWS Secrets Manager secret containing Prefect API key"
}

variable "prefect_api_url" {
  type        = string
}

variable "prefect_account_id" {
  type        = string
}

variable "prefect_workspace_id" {
  type        = string
}

variable "prefect_work_pool_name" {
  type        = string
  default     = "ecs-work-pool"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}
