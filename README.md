# Terraform Multi-Environment (Dev / Preprod / Prod)

This repo contains a minimal, **ready-to-run** Azure Landing Zone skeleton using Terraform with **separate backends** per environment and **GitHub Actions** CI/CD.

## Environments & Backends (Hard-coded)
- **Dev** → RG: `rg-tfstate-dev`, Storage: `satfdev000`, Container: `tfstate`, Key: `dev.tfstate`
- **Preprod** → RG: `rg-tfstate-preprod`, Storage: `satfpp000`, Container: `tfstate`, Key: `preprod.tfstate`
- **Prod** → RG: `rg-tfstate-prod`, Storage: `satfprod000`, Container: `tfstate`, Key: `prod.tfstate`

> Subscription ID (used by all envs): `1c95c3eb-55ac-4d47-bee1-e823c941e413`

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
