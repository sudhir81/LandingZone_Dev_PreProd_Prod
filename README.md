# 🚀 Azure Landing Zone — Dev / PreProd / Prod (Terraform IaC)

This repository provides a **complete, enterprise-grade Azure Landing Zone** built with **Terraform**, supporting three isolated environments — **Development**, **Pre-Production**, and **Production** — following Microsoft's **Cloud Adoption Framework (CAF)**.

It is designed as a secure, scalable, policy-driven foundation for deploying cloud workloads across multiple environments using best practices in **governance, identity, networking, automation, and DevOps.**

---

## 🌐 Architecture Overview

The landing zone follows a **hub-and-spoke model** with centralized governance, shared services, and isolated workloads:

```mermaid

graph TD
    A[Management Group] --> B[Subscription: Platform]
    A --> C[Subscription: Dev]
    A --> D[Subscription: PreProd]
    A --> E[Subscription: Prod]

    B --> F[Core Network Hub (VNet, Firewall, Bastion)]
    C --> G[App Landing Zone - Dev]
    D --> H[App Landing Zone - PreProd]
    E --> I[App Landing Zone - Prod]

    G --> J[App Services / AKS / Storage / DB]
    H --> K[App Services / AKS / Storage / DB]
    I --> L[App Services / AKS / Storage / DB]

----------------------------------------------------------------------------------------------

    ✅ Key Layers:

Layer	       Purpose
Management	   Tenant-level governance, policies, and compliance
Platform	   Shared networking, identity, security, and logging
Landing Zones  Environment-specific infrastructure (Dev, PreProd, Prod)
Workloads	   Applications, data, containers, and services deployed per environment

----------------------------------------------------------------------------------------------

📁 Repository Structure

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

-------------------------------------------------------------------------------------------------

🧱 Key Features

✅ Multi-Environment Support – Independent deployment for Dev, PreProd, and Prod
✅ Secure Networking – Hub-Spoke VNet, subnets, NSGs, and Firewall
✅ Governance & Compliance – Azure Policy, RBAC, and tagging standards
✅ Infrastructure as Code (IaC) – Modular, reusable Terraform codebase
✅ DevOps Automation – GitHub Actions CI/CD workflows for plan/apply/destroy
✅ Secrets Management – Azure Key Vault integrated for sensitive data
✅ Scalable Foundation – Easily extendable for AKS, App Services, Data Platforms, etc.

---------------------------------------------------------------------------------------------------

⚙️ Deployment Guide
1. 📥 Clone the Repository

git clone https://github.com/sudhir81/LandingZone_Dev_PreProd_Prod.git
cd LandingZone_Dev_PreProd_Prod

2. 🔐 Authenticate with Azure

az login

3. 🏗️ Initialize Terraform

Choose your environment folder and run:

cd envs/dev      # or preprod / prod
terraform init
terraform plan
terraform apply
--------------------------------------------------------------------------------------

🤖 CI/CD Pipeline (GitHub Actions)

terraform.yml – Runs terraform init, plan, and apply on push to main.
destroy.yml – Manual workflow to destroy resources per environment.
Environment-specific secrets (AZURE_CREDENTIALS_DEV, etc.) are used for authentication.
---------------------------------------------------------------------------------------

🧱 Terraform Modules
Module	    Purpose
core	    Creates resource groups, key vault, and shared services
network	    Deploys virtual networks, subnets, NSGs, and firewall
identity	Configures managed identities, role assignments, and RBAC
governance	Applies policies, management group structure, and compliance standards
-----------------------------------------------------------------------------------------
🔐 Security Best Practices

allow_blob_public_access = false by default
min_tls_version = "TLS1_2" enforced
All modules designed with least-privilege RBAC principles
Support for private endpoints and secure networking
Integration-ready with Azure Defender, Sentinel, and Security Center
------------------------------------------------------------------------------------------

🗺️ Roadmap

 Add Azure Policy assignments and compliance baselines
 Add Azure Monitor, Log Analytics, and Diagnostic Settings module
 Add sample workload deployment (App Service / AKS)
 Add module unit testing with Terratest
 Integrate Checkov and TFLint into CI/CD pipeline
------------------------------------------------------------------------------------------

🧠 Best Practices Followed

✅ Aligned with Microsoft Cloud Adoption Framework (CAF)
✅ Supports GitOps / DevOps automation workflows
✅ Uses remote state backend with Azure Storage
✅ Built with Terraform modules for reusability and scalability
------------------------------------------------------------------------------------------

📜 License
This project is open source and available under the MIT License.
------------------------------------------------------------------------------------------

🤝 Contributing
Contributions are welcome!
Feel free to fork this repo, open issues, or submit pull requests to improve features, modules, and automation.
------------------------------------------------------------------------------------------

📞 Contact
👤 Author: Sudhir Dalvi
📧 Email: sudhir.dalvi@hotmail.com
🔗 GitHub: https://github.com/sudhir81

