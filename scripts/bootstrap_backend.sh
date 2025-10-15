#!/usr/bin/env bash
set -euo pipefail
LOC="${1:-eastus}"
RG="${2:-rg-tfstate}"
SA="${3:-tfstate$RANDOM$RANDOM}"
CN="tfstate"

echo "Location: $LOC"
echo "Resource Group: $RG"
echo "Storage Account: $SA"
echo "Container: $CN"

az group create -n "$RG" -l "$LOC"
az storage account create -g "$RG" -n "$SA" -l "$LOC" --sku Standard_LRS --allow-blob-public-access false
az storage container create --account-name "$SA" --name "$CN" --auth-mode login

echo "Done. Use this in backend.tf:"
echo "  resource_group_name  = \"$RG\""
echo "  storage_account_name = \"$SA\""
echo "  container_name       = \"$CN\""
