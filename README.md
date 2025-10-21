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
  A[Management Group & Policies] --> B[Platform Subscription]
  A --> C[Development Subscription]
  A --> D[Pre-Production Subscription]
  A --> E[Production Subscription]

  B --> F[Core Services: VNet, Firewall, Bastion, Log Analytics]
  C --> G[Dev Landing Zone: Workload RGs, App Services, AKS, Storage]
  D --> H[PreProd Landing Zone: Workload RGs, Databases, APIs]
  E --> I[Production Landing Zone: Secure, Compliant Workloads]

  F --> J[Shared Services: Key Vault, Monitoring, Sentinel]
  G --> K[Dev Workloads: App Services, AKS, Databases]
  H --> L[PreProd Workloads: API Apps, SQL, Data Services]
  I --> M[Production Workloads: Enterprise Apps, APIs, ML Models].





| Layer             | Purpose                                                    |
| ----------------- | ---------------------------------------------------------- |
| **Management**    | Tenant-wide governance, RBAC, policies, tagging            |
| **Platform**      | Shared networking, logging, monitoring, security           |
| **Landing Zones** | Environment-specific infrastructure (Dev, PreProd, Prod)   |
| **Workloads**     | Application deployments: compute, storage, data, AKS, etc. |
