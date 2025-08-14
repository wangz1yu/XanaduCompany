#!/bin/bash

# Railway后端部署脚本
echo "🚂 开始部署后端API到Railway..."

# 检查是否安装了Railway CLI
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI未安装，请先安装:"
    echo "npm install -g @railway/cli"
    exit 1
fi

# 进入后端目录
cd server

# 登录Railway（如果未登录）
echo "🔐 请确保已登录Railway..."
railway login

# 初始化项目
echo "📝 初始化Railway项目..."
railway init

# 设置环境变量
echo "⚙️ 设置环境变量..."
railway variables set NODE_ENV=production

# 部署
echo "🚀 部署后端API..."
railway up

echo "✅ 后端部署完成！"
echo ""
echo "📋 请记录以下信息:"
echo "1. Railway项目URL（用于更新前端API配置）"
echo "2. 在Railway控制台中配置数据库连接"
echo "3. 更新Vercel项目的环境变量"
