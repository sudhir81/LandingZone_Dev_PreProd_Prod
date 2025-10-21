# Terraform Multi-Environment (Dev / Preprod / Prod)

# 🚀 Azure Landing Zone (Dev / PreProd / Prod) — Terraform IaC

## 📌 Overview
This repository provides a **complete Azure Landing Zone** deployment built with **Terraform** — ready for **Dev**, **PreProd**, and **Production** environments.  
It follows **Microsoft's Cloud Adoption Framework (CAF)** best practices and provides a secure, scalable, and policy-driven foundation for deploying enterprise workloads.

Key features:
- 🌐 Multi-environment infrastructure (Dev / PreProd / Prod)
- 🔐 Secure governance & RBAC policies
- 🏗️ Reusable Terraform modules
- ⚙️ GitHub Actions CI/CD pipelines
- 📊 Centralized logging, security, and network configuration

---

## 🏗️ Architecture Overview

The solution follows a **hub-spoke landing zone architecture**:

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

    G --> J[App Service / AKS / Storage / DB]
    H --> K[App Service / AKS / Storage / DB]
    I --> L[App Service / AKS / Storage / DB]

## Layout
```
.
├── .github/workflows
│   ├── terraform.yml        # CI/CD: plan on PR, apply on main for all envs
│   └── destroy.yml          # Manual destroy per environment
├── envs
│   ├── dev
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   ├── versions.tf
│   │   └── dev.tfvars
│   ├── preprod
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   ├── versions.tf
│   │   └── preprod.tfvars
│   └── prod
│       ├── backend.tf
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       ├── versions.tf
│       └── prod.tfvars
├── modules
│   └── core
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── versions.tf
└── scripts
    └── bootstrap_backend.sh
```

## What it deploys
A single **Resource Group** per environment: `rg-<env>-core` in the chosen location (from env tfvars). This is minimal on purpose and a safe base to expand.

---

## Prereqs
1. **Azure**: Storage accounts + containers already created (as listed above).
2. **Service Principals** (one per env) + GitHub Secrets:
   - `AZURE_CREDENTIALS_DEV`      → JSON from `az ad sp create-for-rbac --sdk-auth`
   - `AZURE_CREDENTIALS_PREPROD`  → JSON
   - `AZURE_CREDENTIALS_PROD`     → JSON

> Secrets path: **Repo → Settings → Secrets and variables → Actions → New repository secret**.

---

## Local usage (optional)
```bash
cd envs/dev      # or preprod/prod
terraform init -reconfigure
terraform plan -var-file="dev.tfvars" -out=tfplan
terraform apply "tfplan"
```

## GitHub Actions
- **terraform.yml**: Runs `init/validate/plan` for all envs on PR, and **auto-applies on main**.
- **destroy.yml**: Manual `workflow_dispatch` — choose environment to destroy.

---

## Customize
- Add resources inside `modules/core` (e.g., VNets, Policies).
- Pass new variables via each env `*.tfvars` file.
