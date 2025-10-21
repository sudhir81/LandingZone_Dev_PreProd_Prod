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

    B --> F[Core Network Hub - VNet & Firewall]
    C --> G[App Landing Zone - Dev]
    D --> H[App Landing Zone - PreProd]
    E --> I[App Landing Zone - Prod]

    G --> J[App Services / AKS / Storage / DB]
    H --> K[App Services / AKS / Storage / DB]
    I --> L[App Services / AKS / Storage / DB]
