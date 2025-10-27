# Azure Sora 2 UI

Next-generation video generation interface powered by Azure, built with Next.js and deployed to Azure App Service.

## Features

- 🎬 Modern, responsive UI for video generation
- ☁️ Optimized for Azure App Service deployment
- ⚡ Built with Next.js 16, React 19, and TypeScript
- 🎨 Styled with Tailwind CSS
- 🚀 Automated deployment via GitHub Actions

## Prerequisites

- Node.js 20.x or higher
- npm or yarn
- Azure subscription (for deployment)
- Azure App Service instance

## Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/jackylam0812/azure-sora-2-ui.git
   cd azure-sora-2-ui
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Run the development server:
   ```bash
   npm run dev
   ```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Building for Production

```bash
npm run build
npm start
```

## Deployment to Azure App Service

### Option 1: Automated Deployment (GitHub Actions)

1. **Create an Azure App Service**:
   - Go to [Azure Portal](https://portal.azure.com)
   - Create a new Web App
   - Choose Node.js 20 LTS as the runtime stack
   - Select your preferred region and pricing tier

2. **Configure Deployment**:
   - In your Azure App Service, go to "Deployment Center"
   - Download the publish profile
   - In your GitHub repository settings, go to "Secrets and variables" > "Actions"
   - Create a new secret named `AZURE_WEBAPP_PUBLISH_PROFILE`
   - Paste the contents of the publish profile

3. **Update the workflow file**:
   - Edit `.github/workflows/azure-deploy.yml`
   - Update `AZURE_WEBAPP_NAME` to match your Azure App Service name

4. **Deploy**:
   - Push to the `main` branch or manually trigger the workflow
   - The GitHub Action will automatically build and deploy your application

### Option 2: Manual Deployment

1. **Build the application**:
   ```bash
   npm install
   npm run build
   ```

2. **Deploy using Azure CLI**:
   ```bash
   az login
   az webapp up --name <your-app-name> --resource-group <your-resource-group>
   ```

3. **Deploy using VS Code**:
   - Install the Azure App Service extension
   - Right-click on your App Service and select "Deploy to Web App"

### Option 3: Deploy from ZIP

1. Create a deployment package:
   ```bash
   npm install
   npm run build
   zip -r deploy.zip .next public package.json package-lock.json next.config.ts server.js web.config node_modules
   ```

2. Deploy using Azure CLI:
   ```bash
   az webapp deploy --resource-group <resource-group> --name <app-name> --src-path deploy.zip
   ```

## Azure App Service Configuration

### Application Settings

Add the following environment variables in your Azure App Service configuration:

- `WEBSITE_NODE_DEFAULT_VERSION`: `20-lts`
- `PORT`: (automatically set by Azure)
- `NODE_ENV`: `production`

### Startup Command

Set the startup command in Azure App Service:
```bash
node server.js
```

Or use the provided startup script:
```bash
bash startup.sh
```

## Project Structure

```
azure-sora-2-ui/
├── app/                    # Next.js app directory
│   ├── layout.tsx         # Root layout
│   ├── page.tsx           # Home page
│   └── globals.css        # Global styles
├── public/                # Static assets
├── .github/
│   └── workflows/
│       └── azure-deploy.yml  # GitHub Actions workflow
├── server.js              # Custom server for Azure
├── web.config             # IIS configuration for Azure
├── startup.sh             # Startup script
├── next.config.ts         # Next.js configuration
├── package.json           # Dependencies and scripts
└── README.md             # This file
```

## Technologies Used

- **Next.js 16**: React framework with App Router
- **React 19**: UI library
- **TypeScript**: Type-safe JavaScript
- **Tailwind CSS v4**: Utility-first CSS framework
- **Azure App Service**: Cloud hosting platform

## Troubleshooting

### Application won't start on Azure

- Check the startup command is set to `node server.js`
- Verify `PORT` environment variable is available
- Check Application Logs in Azure Portal

### Build fails

- Ensure Node.js version matches (20.x)
- Clear npm cache: `npm cache clean --force`
- Delete `node_modules` and `.next`, then reinstall: `npm install`

### Static files not loading

- Verify `web.config` is deployed
- Check that `.next` and `public` folders are included in deployment

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - feel free to use this project for your own purposes.

## Support

For issues and questions:
- Create an issue in this repository
- Check Azure App Service documentation
- Review Next.js deployment guides
