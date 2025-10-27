# Azure App Service Deployment Guide

This document provides detailed instructions for deploying the Azure Sora 2 UI to Azure App Service.

## Prerequisites

Before deploying, ensure you have:

1. An active Azure subscription
2. Azure CLI installed (optional, for CLI deployment)
3. Node.js 20.x or higher installed locally
4. Git installed

## Step-by-Step Deployment

### 1. Create Azure App Service

#### Using Azure Portal

1. Sign in to the [Azure Portal](https://portal.azure.com)
2. Click "Create a resource"
3. Search for "Web App" and select it
4. Click "Create"
5. Fill in the required information:
   - **Subscription**: Select your subscription
   - **Resource Group**: Create new or use existing
   - **Name**: Choose a unique name (e.g., `azure-sora-2-ui`)
   - **Publish**: Code
   - **Runtime stack**: Node 20 LTS
   - **Operating System**: Linux (recommended) or Windows
   - **Region**: Select your preferred region
   - **Pricing Plan**: Choose based on your needs (Free F1 for testing, B1 or higher for production)
6. Click "Review + Create", then "Create"

#### Using Azure CLI

```bash
# Login to Azure
az login

# Create a resource group
az group create --name azure-sora-rg --location eastus

# Create an App Service Plan
az appservice plan create \
  --name azure-sora-plan \
  --resource-group azure-sora-rg \
  --sku B1 \
  --is-linux

# Create the Web App
az webapp create \
  --name azure-sora-2-ui \
  --resource-group azure-sora-rg \
  --plan azure-sora-plan \
  --runtime "NODE:20-lts"
```

### 2. Configure App Service Settings

#### Application Settings

1. Go to your App Service in Azure Portal
2. Navigate to "Configuration" under Settings
3. Add the following Application Settings:

| Name | Value | Description |
|------|-------|-------------|
| `WEBSITE_NODE_DEFAULT_VERSION` | `20-lts` | Node.js version |
| `NODE_ENV` | `production` | Environment mode |
| `SCM_DO_BUILD_DURING_DEPLOYMENT` | `true` | Enable build on deployment |

4. Click "Save"

#### Startup Command

1. In the Configuration page, go to "General settings"
2. Set the Startup Command to: `node server.js`
3. Click "Save"

### 3. Deploy Using GitHub Actions (Recommended)

#### Step 3.1: Get Publish Profile

1. In Azure Portal, go to your App Service
2. Click "Get publish profile" in the Overview section
3. Save the downloaded `.PublishSettings` file

#### Step 3.2: Configure GitHub Secrets

1. Go to your GitHub repository
2. Navigate to "Settings" > "Secrets and variables" > "Actions"
3. Click "New repository secret"
4. Name: `AZURE_WEBAPP_PUBLISH_PROFILE`
5. Value: Paste the contents of the publish profile file
6. Click "Add secret"

#### Step 3.3: Update Workflow

1. Edit `.github/workflows/azure-deploy.yml`
2. Update the `AZURE_WEBAPP_NAME` environment variable to match your App Service name:
   ```yaml
   env:
     AZURE_WEBAPP_NAME: your-app-service-name  # Change this
   ```

#### Step 3.4: Deploy

1. Commit and push your changes to the `main` branch:
   ```bash
   git add .
   git commit -m "Configure Azure deployment"
   git push origin main
   ```

2. The GitHub Action will automatically trigger and deploy your application
3. Monitor the deployment in the "Actions" tab of your GitHub repository

### 4. Alternative Deployment Methods

#### Method A: Local Git Deployment

1. Get the Git deployment URL from Azure Portal:
   ```bash
   az webapp deployment source config-local-git \
     --name azure-sora-2-ui \
     --resource-group azure-sora-rg
   ```

2. Add Azure as a Git remote:
   ```bash
   git remote add azure <git-url-from-step-1>
   ```

3. Deploy:
   ```bash
   git push azure main
   ```

#### Method B: ZIP Deployment

1. Build the application:
   ```bash
   npm install
   npm run build
   ```

2. Create a ZIP file:
   ```bash
   zip -r deploy.zip .next public package.json package-lock.json next.config.ts server.js web.config node_modules
   ```

3. Deploy using Azure CLI:
   ```bash
   az webapp deploy \
     --resource-group azure-sora-rg \
     --name azure-sora-2-ui \
     --src-path deploy.zip
   ```

#### Method C: VS Code Extension

1. Install the "Azure App Service" extension in VS Code
2. Sign in to Azure
3. Right-click on your App Service
4. Select "Deploy to Web App"
5. Choose your project folder

### 5. Verify Deployment

1. After deployment completes, navigate to your App Service URL:
   `https://your-app-name.azurewebsites.net`

2. You should see the Azure Sora 2 UI homepage

### 6. Monitoring and Troubleshooting

#### View Application Logs

**Azure Portal:**
1. Go to your App Service
2. Navigate to "Monitoring" > "Log stream"
3. View real-time logs

**Azure CLI:**
```bash
az webapp log tail \
  --name azure-sora-2-ui \
  --resource-group azure-sora-rg
```

#### Common Issues

**Issue: Application doesn't start**
- Check that the startup command is set to `node server.js`
- Verify Node.js version is set to 20-lts
- Check application logs for errors

**Issue: Build fails during deployment**
- Ensure all dependencies are in `package.json`
- Check that `SCM_DO_BUILD_DURING_DEPLOYMENT` is set to `true`
- Verify enough disk space and memory is available

**Issue: Static files not loading**
- Ensure `web.config` is deployed
- Check that `.next` and `public` folders are included
- Verify rewrite rules in `web.config`

#### Enable Application Insights (Optional)

1. Create an Application Insights resource
2. Link it to your App Service
3. Monitor performance, errors, and usage

## Production Checklist

Before going to production, ensure:

- [ ] App Service Plan is appropriate for expected traffic
- [ ] Application Insights is configured for monitoring
- [ ] Custom domain is configured (if needed)
- [ ] SSL certificate is configured
- [ ] Environment variables are properly set
- [ ] Deployment slots are configured (for zero-downtime deployments)
- [ ] Auto-scaling rules are configured (if needed)
- [ ] Backup and disaster recovery plan is in place
- [ ] Security best practices are implemented

## Scaling

### Vertical Scaling (Scale Up)

1. Go to "Scale up (App Service plan)" in Azure Portal
2. Select a higher tier with more resources
3. Click "Apply"

### Horizontal Scaling (Scale Out)

1. Go to "Scale out (App Service plan)"
2. Configure auto-scaling rules or manual instance count
3. Save configuration

## Cost Optimization

- Use Free/Shared tier for development and testing
- Use B1 or higher for production
- Enable auto-scaling to optimize resource usage
- Monitor and analyze usage with Azure Cost Management

## Security Best Practices

1. Enable HTTPS only
2. Use Managed Identity for accessing Azure resources
3. Configure CORS settings appropriately
4. Keep Node.js and dependencies updated
5. Use Azure Key Vault for sensitive configuration
6. Enable Azure Defender for App Service

## Next Steps

- Configure custom domain
- Set up deployment slots for staging
- Implement CI/CD best practices
- Monitor application performance
- Set up alerts and notifications
- Implement backup strategy

## Support

For issues and questions:
- [Azure App Service Documentation](https://docs.microsoft.com/azure/app-service/)
- [Next.js Deployment Documentation](https://nextjs.org/docs/deployment)
- [Azure Support](https://azure.microsoft.com/support/)
