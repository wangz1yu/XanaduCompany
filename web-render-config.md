# 🌐 前端门户 Render 部署配置

## 部署步骤

### 1. 创建Static Site
- **Name**: `xanadu-web`
- **Build Command**: `cd web && npm install && npm run build`
- **Publish Directory**: `web/dist`

### 2. 环境变量
```
NODE_ENV=production
VUE_APP_BASE_URL=https://xanadu-backend.onrender.com/api/v1
VUE_APP_PRODURL=https://xanadu-admin.onrender.com/#/login
```

### 3. 构建优化
构建过程会自动：
- 安装依赖
- 编译TypeScript
- 打包生产版本
- 部署到CDN

预计构建时间: 3-5分钟
