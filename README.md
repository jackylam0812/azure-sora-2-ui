# Azure Sora 2 UI

Deploy the Azure Sora 2 UI to Azure App Service.

## Contents

- Purpose
- Prerequisites
- Azure CLI Login (User & Service Principal)
- Set Subscription & Verify Context
- Optional: Create Service Principal
- Basic Deployment Flow (App Service)
- Common Commands Cheat Sheet

## 1. Purpose

This repository is intended to help you deploy the Sora 2 UI to Azure App Service using Azure CLI.

## 2. Prerequisites

- Azure subscription
- Installed Azure CLI (≥ 2.50): https://learn.microsoft.com/cli/azure/install-azure-cli
- (Optional) Node.js / build tooling if the UI needs a local build
- Permissions to create resource groups & App Service resources (or a service principal)

## 3. Azure CLI Login

### A. Interactive (User Account)

```bash
az login
```

If a browser cannot be opened (e.g. remote terminal):

```bash
az login --use-device-code
```

### B. Service Principal (Non-Interactive / CI)

```bash
az login --service-principal \
  --username <APP_ID> \
  --password <CLIENT_SECRET> \
  --tenant <TENANT_ID>
```

Environment variable form (recommended in CI):

```bash
az login --service-principal \
  -u "$AZURE_CLIENT_ID" \
  -p "$AZURE_CLIENT_SECRET" \
  --tenant "$AZURE_TENANT_ID"
```

### C. List Available Subscriptions

```bash
az account list --output table
```

## 4. Set Subscription & Verify Context

Set the active subscription (use either ID or name):

```bash
az account set --subscription <SUBSCRIPTION_ID_OR_NAME>
```

Verify current account context:

```bash
az account show --output table
```

## 5. (Optional) Create a Service Principal for Deployment

Run once (replace placeholders):

```bash
az ad sp create-for-rbac \
  --name "sora2-ui-deployer" \
  --role Contributor \
  --scopes /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RESOURCE_GROUP> \
  --sdk-auth
```

Output includes `clientId`, `clientSecret`, `tenantId`. Store securely (GitHub Actions secrets, etc.).

Revoke (if needed):

```bash
az ad sp delete --id <APP_ID>
```

## 6. Basic Deployment Flow (Azure App Service)

Adjust runtime and plans to match the UI (examples below are placeholders).

Set variables:

```bash
RESOURCE_GROUP="sora2-ui-rg"
LOCATION="eastasia"
PLAN_NAME="sora2-ui-plan"
APP_NAME="sora2-ui-app"
```
run sh deploy_app.sh


## 7. Cleanup

```bash
az group delete --name "$RESOURCE_GROUP" --yes --no-wait
```
---

Feel free to tailor runtime, build, and deployment steps to the actual tech stack of the UI.
