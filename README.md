# Deploying Prefect Workers on AWS ECS Fargate with Terraform

![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-blue?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-ECS%2FFargate-orange?logo=amazon-aws)
![Prefect](https://img.shields.io/badge/Prefect-Cloud-blue?logo=prefect)

This project automates the provisioning of infrastructure to deploy a **Prefect 2 `dev-worker`** on **AWS ECS Fargate**, using Terraform modules. The system sets up networking, IAM roles, a Cloud Map namespace, Secrets Manager integration, and an ECS service that registers a worker with Prefect Cloud.

---

## Project Structure

```bash
prefect-ecs-terraform/
├── main.tf                  # Root config - wires all modules
├── variables.tf             # Root variables
├── outputs.tf               # Root outputs
├── terraform.tf             # Required Terraform block
├── terraform.tfvars         # Secret config (gitignored)

# Modules
├── vpc/                     # VPC, subnets, route tables
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf

├── iam/                     # ECS Task Execution Role & Policies
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf

├── ecs-cluster/             # ECS cluster & service discovery
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf

├── secrets-manager/        # Stores Prefect API key securely
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf

└── ecs-task-service/        # ECS Task Definition & Fargate service
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```
Cloud Architecture Diagram

![Cloud Architecture Diagram](./ECS-Prefect-Architecture%20Diagram.png)

Prerequisites

Terraform v1.5+
AWS CLI
Prefect CLI
An active Prefect Cloud account
A Push Work Pool created in Prefect Cloud

⚙Configuration
Create a terraform.tfvars file in the root directory:
``` bash
aws_region              = "us-east-1"
prefect_api_key         = "<your-prefect-api-key>"
prefect_api_url         = "https://api.prefect.cloud/api"
prefect_account_id      = "<your-prefect-account-id>"
prefect_workspace_id    = "<your-prefect-workspace-id>"
prefect_work_pool_name  = "ecs-work-pool"
```

Deploying to AWS
1. Initialize Terraform
``` bash
terraform init
``` 
3. Review the Execution Plan
``` bash
terraform plan
``` 
5. Apply the Infrastructure
``` bash
terraform apply
``` 
Confirm with yes when prompted. Terraform will provision:
VPC with public & private subnets
IAM roles for ECS
ECS cluster with Cloud Map service discovery
Secrets Manager for Prefect API key
ECS Fargate service running the Prefect dev-worker

Verifying the Deployment

Go to Prefect Cloud
Navigate to your ecs-work-pool
Ensure the worker appears online
Run a test flow and confirm it's picked up
You can also check AWS Console → ECS → Clusters → Services for the running task.

Cleanup
To destroy all provisioned infrastructure:
``` bash
terraform destroy
``` 
