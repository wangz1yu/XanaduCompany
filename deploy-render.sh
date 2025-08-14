#!/bin/bash

echo "🎨 开始部署后端API到Render..."

# 检查是否在项目根目录
if [ ! -f "render.yaml" ]; then
    echo "❌ 请在项目根目录执行此脚本"
    exit 1
fi

echo "📋 Render部署指南："
echo "1. 访问 https://render.com/"
echo "2. 使用GitHub账户登录"
echo "3. 连接此GitHub仓库"
echo "4. 选择 'Web Service'"
echo "5. 配置如下："
echo "   - Build Command: cd server && npm install"
echo "   - Start Command: cd server && npm start"
echo "   - Port: 10000"
echo ""
echo "📝 环境变量配置："
echo "   NODE_ENV = production"
echo "   DATABASE_URL = [需要配置云数据库URL]"
echo ""
echo "🔗 部署完成后，更新前端配置中的API地址"
echo ""
echo "💡 提示：Render免费版有以下限制："
echo "   - 750小时/月的运行时间"
echo "   - 15分钟无活动后会休眠"
echo "   - 但对于开发和演示来说完全够用"

echo ""
echo "✅ 部署配置文件已生成: render.yaml"
echo "🚀 请按照上述指南在Render平台完成部署"
