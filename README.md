### **Final Optimized README**

```markdown
# DevOps Challenge — Production-Ready Application Deployment

**Live Application URL:** [http://devops-challenge-prod-alb-793309554.us-east-1.elb.amazonaws.com](http://devops-challenge-prod-alb-793309554.us-east-1.elb.amazonaws.com)  
**Status:** ![Success](https://img.shields.io/badge/Status-Success-success) ![AWS](https://img.shields.io/badge/Cloud-AWS-orange) ![Terraform](https://img.shields.io/badge/IaC-Terraform-blueviolet)

**Author:** Mary Sandra  
**AWS Account:** 660405908596  
**Region:** us-east-1  
**Repository:** [https://github.com/Mary-Sandra/devops-work-project](https://github.com/Mary-Sandra/devops-work-project)

---

##   Architecture Overview

The application follows a modern cloud-native architecture, ensuring high availability and security.

```text
                          Internet
                             │
                             ▼
                    ┌─────────────────┐
                    │  ALB (Port 80)  │
                    │  Public Subnets │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │  ECS Fargate    │
                    │  FastAPI App    │
                    │  Private Subnets│
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │  RDS PostgreSQL │
                    │  Private Subnets│
                    └─────────────────┘

CI/CD Flow:
Git Push (main) → GitHub Actions → Pytest → Docker Build → Push ECR → Deploy ECS → Health Check

```

---

##   Repository Structure

The project uses a **Modular Root** structure. While `providers.tf` handles the AWS connection, the actual infrastructure components are defined as reusable modules and orchestrated in the root `main.tf`.

```text
DevOps-Project/
├── .github/workflows/
│   └── deploy.yml           # Automated CI/CD Pipeline
├── app/
│   ├── app/                 # FastAPI Logic (Models, Routes, DB)
│   ├── tests/               # Pytest suite
│   ├── Dockerfile           # Optimized Multi-stage build
│   └── requirements.txt     # Python dependencies
└── terraform/
    ├── main.tf              # ROOT MODULE: Calls all child modules below
    ├── providers.tf         # AWS Provider & S3 Remote State Backend
    ├── variables.tf         # Global Input Variables
    ├── outputs.tf           # ALB DNS & Resource Outputs
    └── modules/             # CHILD MODULES: Defined Logic
        ├── networking/      # VPC, Subnets, NAT Gateway, Security Groups
        ├── ecr/             # Private Docker Registry & Lifecycle Policies
        ├── iam/             # ECS Execution & Task Role Definitions
        ├── rds/             # Managed PostgreSQL Instance
        └── ecs/             # Cluster, Fargate Service, Task Def, ALB

```

---

##   Design Decisions & DevOps Best Practices

### **1. Infrastructure as Code (IaC) & Standards**

* **Official Sources:** All AWS resources were provisioned using official patterns from the [Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest).
* **Modular Design:** Infrastructure is broken into discrete modules (`networking`, `ecs`, `rds`, etc.) for reusability.
* **Remote State:** State is stored in **S3** with versioning to allow collaboration and prevent state loss.

### **2. Compute Strategy: ECS vs EKS**

* **Cost Efficiency:** **AWS ECS Fargate** was selected over EKS (Kubernetes) to remain within the **AWS Free Tier** limits and avoid the ~$72/month EKS control plane cost.
* **Operational Simplicity:** ECS provides a serverless experience perfectly suited for this microservice architecture.

### **3. CI/CD & Security**

* **Official Integration:** Built following [Official GitHub Actions Documentation](https://docs.github.com/en/actions).
* **Network Isolation:** RDS and ECS reside in **Private Subnets**. Only the ALB is public-facing.
* **Least Privilege:** Separate IAM roles are used for Task Execution vs. Application Runtime.

---

##   How to Run

### **Local Development**

```bash
cd app
docker-compose up --build

```

### **Infrastructure Deployment**

```bash
cd terraform
terraform init
terraform apply -auto-approve

```

---

##   Cleanup

To terminate all AWS resources and stop billing:

```bash
cd terraform
terraform destroy -auto-approve

```

```
