variable "secret_name" {
  description = "Name of the AWS Secrets Manager secret"
  type        = string
  default     = "prefect-api-key"
}

variable "prefect_api_key" {
  description = "The Prefect Cloud API key"
  type        = string
  sensitive   = true
}
