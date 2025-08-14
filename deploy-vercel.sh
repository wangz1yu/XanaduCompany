#!/bin/bash

# Vercel部署脚本
echo "🚀 开始部署XanaduCompany到Vercel..."

# 检查是否安装了Vercel CLI
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI未安装，正在安装..."
    npm install -g vercel
fi

# 部署Web前端
echo "📦 部署Web前端..."
cd web
echo "正在构建Web前端..."
npm run build
echo "正在部署到Vercel..."
vercel --prod --name xanadu-web
cd ..

# 部署Admin后台
echo "📦 部署Admin后台..."
cd admin
echo "正在构建Admin后台..."
NODE_OPTIONS="--openssl-legacy-provider" npm run build:prod
echo "正在部署到Vercel..."
vercel --prod --name xanadu-admin
cd ..

echo "✅ 部署完成！"
echo ""
echo "📋 下一步操作："
echo "1. 部署后端API到Railway/Render"
echo "2. 设置数据库（PlanetScale/Supabase）"
echo "3. 更新Vercel环境变量中的API URL"
echo "4. 测试所有功能"
