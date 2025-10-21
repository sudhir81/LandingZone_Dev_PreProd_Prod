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
