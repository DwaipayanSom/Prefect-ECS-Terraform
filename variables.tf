variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "prefect_api_key" {
  description = "Prefect Cloud API Key"
  type        = string
  sensitive   = true
}

variable "prefect_api_url" {}
variable "prefect_account_id" {}
variable "prefect_workspace_id" {}
variable "prefect_work_pool_name" {
  default = "ecs-work-pool"
}

