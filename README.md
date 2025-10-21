# 🚀 Azure Landing Zone — Dev / PreProd / Prod (Terraform IaC)

![Terraform](https://img.shields.io/badge/Terraform-v1.9-blueviolet?logo=terraform)
![AzureRM](https://img.shields.io/badge/AzureRM-~%3E3.100-0078D7?logo=microsoft-azure)
![Build Status](https://img.shields.io/github/actions/workflow/status/sudhir81/LandingZone_Dev_PreProd_Prod/terraform.yml?label=CI%2FCD%20Pipeline)
![Infrastructure as Code](https://img.shields.io/badge/IaC-Terraform%20%26%20Azure-blue)
![Code Quality](https://img.shields.io/badge/Code%20Quality-Enterprise%20Grade-success)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📘 Project Overview

This repository provides a **complete, enterprise-grade Azure Landing Zone** built with **Terraform**, designed for multi-environment deployment — **Development**, **Pre-Production**, and **Production** — following **Microsoft’s Cloud Adoption Framework (CAF)**.

It provides a **secure, scalable, policy-driven foundation** to deploy cloud workloads while enforcing governance, identity, security, networking, and automation best practices.

---

## 🧠 Tech Stack & Tools

| Component | Technology Used |
|----------|------------------|
| IaC | Terraform v1.9 |
| Cloud Provider | Azure Cloud |
| Provider Plugin | AzureRM ~>3.100 |
| DevOps | GitHub Actions CI/CD |
| Identity | Azure AD / Microsoft Entra ID |
| Networking | VNet, Subnets, NSG, Azure Firewall |
| Security | Key Vault, RBAC, Policies, Private Endpoints |
| State Mgmt | Azure Storage (Remote Backend) |

---

## 🏗️ Enterprise Architecture

The solution follows a **hub-and-spoke landing zone model** with centralized governance, platform services, and isolated workload environments.
```mermaid
graph TD
  A[Management Group and Policies] --> B[Platform Subscription]
  A --> C[Development Subscription]
  A --> D[Pre-Production Subscription]
  A --> E[Production Subscription]

  B --> F[Core Services - VNet, Firewall, Bastion, Log Analytics]
  C --> G[Dev Landing Zone - Workload RGs and App Services]
  D --> H[PreProd Landing Zone - Workload RGs and Databases]
  E --> I[Production Landing Zone - Secure Workloads]

  F --> J[Shared Services - Key Vault and Monitoring]
  G --> K[Dev Workloads - App Services and AKS]
  H --> L[PreProd Workloads - APIs and Data Services]
  I --> M[Production Workloads - Enterprise Apps and ML Models]

Key Layers

| Layer             | Purpose                                                    |
| ----------------- | ---------------------------------------------------------- |
| **Management**    | Tenant-wide governance, RBAC, policies, tagging            |
| **Platform**      | Shared networking, logging, monitoring, security           |
| **Landing Zones** | Environment-specific infrastructure (Dev, PreProd, Prod)   |
| **Workloads**     | Application deployments: compute, storage, data, AKS, etc. |


Repo Structure

├── envs/
│   ├── dev/             # Development environment
│   ├── preprod/         # Pre-production environment
│   └── prod/            # Production environment
│
├── modules/
│   ├── core/            # Resource groups, key vault, shared components
│   ├── network/         # Virtual networks, subnets, NSGs, firewall
│   ├── identity/        # Managed identities, RBAC
│   └── governance/      # Policies, management groups
│
├── .github/workflows/   # CI/CD pipelines for Terraform
├── backend.tf.example   # Remote backend state example
└── README.md


🧱 Key Features
✅ Multi-Environment Landing Zones – Dev, PreProd, Prod
✅ Secure Networking – Hub-Spoke VNet, NSG, Azure Firewall
✅ Governance & Compliance – Policies, RBAC, Tagging Standards
✅ Infrastructure as Code – Reusable Terraform modules
✅ CI/CD Automation – GitHub Actions for plan, apply, destroy
✅ Secrets Management – Azure Key Vault integrated
✅ Scalable & Extensible – Ready for AKS, App Services, Data & AI workloads


⚙️ Deployment Guide
1. 📥 Clone the Repository

git clone https://github.com/sudhir81/LandingZone_Dev_PreProd_Prod.git
cd LandingZone_Dev_PreProd_Prod
2. 🔐 Authenticate with Azure

az login
3. 🏗️ Deploy Infrastructure
Choose your environment:

cd envs/dev       # or preprod / prod
terraform init
terraform plan
terraform apply

🤖 CI/CD Pipeline (GitHub Actions)
Workflow	Description
terraform.yml	Runs terraform init, plan, and apply on push to main
destroy.yml	Manual workflow to destroy resources
Secrets	Store service principal credentials in GitHub Secrets (AZURE_CREDENTIALS_DEV, etc.)

💡 Optional enhancements:
* Add tflint and checkov for IaC scanning
* Add terraform fmt & validate for code quality checks

🧩 Terraform Modules
Module	Purpose
core	Creates resource groups, Key Vault, shared services
network	Deploys VNet, subnets, NSGs, firewall
identity	Configures managed identities, RBAC
governance	Applies Azure Policy, management groups, and tagging

🔐 Security Best Practices
* allow_blob_public_access = false by default
* min_tls_version = "TLS1_2" enforced
* All modules designed with least-privilege RBAC
* Private Endpoints for sensitive workloads
* Ready for Azure Defender, Sentinel, and Security Center integration

🗺️ Roadmap
* Add Azure Policy compliance modules
* Add monitoring & diagnostic settings automation
* Add AKS / App Service workload examples
* Add Terratest & unit testing for modules
* Integrate Checkov & TFLint into pipelines

🧠 Best Practices Followed
✅ Built with Microsoft Cloud Adoption Framework (CAF) principles
✅ Fully GitOps-ready with Terraform + GitHub Actions
✅ Remote backend with secure state management
✅ Modular design for scalability and reusability

📜 License
This project is licensed under the MIT License.

📞 Contact
👤 Author: Sudhir Dalvi
📧 Email: sudhir.dalvi@hotmail.com
🔗 GitHub: https://github.com/sudhir81




  
