#!/bin/bash

# ====== 配置区域 ======
RESOURCE_GROUP="rg-sora2ui"
LOCATION="eastasia"
APP_PLAN="plan-sora2ui"
WEBAPP_NAME="sora2ui-app"   # 必须全局唯一
DOCKER_IMAGE="jackylam0083/sora2-ui:latest"
CONTAINER_PORT=8009

# ====== 检查是否已登录 ======
echo "🔍 检查 Azure 登录状态..."
LOGIN_CHECK=$(az account show 2>/dev/null)

if [ -z "$LOGIN_CHECK" ]; then
  echo "❌ 未检测到 Azure 登录。请先运行以下命令登录："
  echo "   az login --use-device-code"
  echo "然后重新执行本脚本。"
  exit 1
fi

echo "✅ 已登录到 Azure 订阅：$(az account show --query name -o tsv)"

# ====== 创建资源组 ======
echo "🧱 创建资源组：$RESOURCE_GROUP"
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# ====== 检查并创建 App Service 计划 ======
PLAN_LOCATION=$(az appservice plan show \
  --name $APP_PLAN \
  --resource-group $RESOURCE_GROUP \
  --query location -o tsv 2>/dev/null)

if [ -z "$PLAN_LOCATION" ]; then
  echo "🚀 创建 App Service 计划：$APP_PLAN (SKU: P0v3, 区域: $LOCATION)"
  az appservice plan create \
    --name $APP_PLAN \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku P0v3 \
    --is-linux
else
  echo "ℹ️ 已存在 App Service 计划 ($APP_PLAN)，区域：$PLAN_LOCATION"
  if [ "$PLAN_LOCATION" != "$LOCATION" ]; then
    echo "⚠️ 计划区域与目标区域 ($LOCATION) 不匹配，将删除并重新创建..."
    az appservice plan delete \
      --name $APP_PLAN \
      --resource-group $RESOURCE_GROUP -y
    az appservice plan create \
      --name $APP_PLAN \
      --resource-group $RESOURCE_GROUP \
      --location $LOCATION \
      --sku P0v3 \
      --is-linux
  fi
fi

# ====== 创建 Web App ======
echo "🐳 创建 Web App：$WEBAPP_NAME"
az webapp create \
  --resource-group $RESOURCE_GROUP \
  --plan $APP_PLAN \
  --name $WEBAPP_NAME \
  --deployment-container-image-name $DOCKER_IMAGE

# ====== 设置容器端口 ======
echo "⚙️ 配置容器端口为 $CONTAINER_PORT"
az webapp config appsettings set \
  --resource-group $RESOURCE_GROUP \
  --name $WEBAPP_NAME \
  --settings WEBSITES_PORT=$CONTAINER_PORT

# ====== 启用容器日志 ======
echo "📜 启用容器日志"
az webapp log config \
  --name $WEBAPP_NAME \
  --resource-group $RESOURCE_GROUP \
  --docker-container-logging filesystem

# ====== 获取应用网址 ======
URL="https://${WEBAPP_NAME}.azurewebsites.net"
echo ""
echo "🌍 部署完成！访问地址：$URL"
echo ""
echo "📡 实时查看容器日志请运行："
echo "az webapp log tail --name $WEBAPP_NAME --resource-group $RESOURCE_GROUP"
