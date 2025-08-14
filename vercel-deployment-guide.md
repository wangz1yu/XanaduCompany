# Vercel部署指南

## 部署架构

### 前端部署到Vercel
- **Web前端**: https://your-web.vercel.app
- **Admin后台**: https://your-admin.vercel.app

### 后端部署方案
1. **Railway/Render**: 部署Node.js API
2. **PlanetScale/Supabase**: 托管MySQL数据库
3. **或使用Vercel Edge Functions**: 轻量级API

## 配置步骤

### 1. Web前端Vercel配置

```json
// web/vercel.json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

### 2. Admin后台Vercel配置

```json
// admin/vercel.json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

### 3. 环境变量配置

```bash
# Web前端环境变量
VUE_APP_BASE_API=https://your-api.railway.app/api

# Admin后台环境变量  
VUE_APP_BASE_API=https://your-api.railway.app/api/v1
```

## 数据库迁移

### 选项1: PlanetScale (推荐)
```bash
# 安装PlanetScale CLI
npm install -g @planetscale/cli

# 创建数据库
pscale database create xanadu-db

# 导入现有数据
pscale shell xanadu-db main < server/init/initial_data.sql
```

### 选项2: Supabase
```sql
-- 在Supabase控制台中执行
-- 导入server/init/initial_data.sql内容
```

## 后端API部署

### 选项1: Railway
```bash
# 安装Railway CLI
npm install -g @railway/cli

# 部署后端
cd server
railway login
railway init
railway up
```

### 选项2: Render
```yaml
# render.yaml
services:
  - type: web
    name: xanadu-api
    env: node
    buildCommand: npm install
    startCommand: npm start
    envVars:
      - key: NODE_ENV
        value: production
      - key: DATABASE_URL
        fromDatabase:
          name: xanadu-db
          property: connectionString
```

### 选项3: Vercel Edge Functions (简化版)
```javascript
// api/auth/login.js
export default async function handler(req, res) {
  if (req.method === 'POST') {
    // 简化的登录逻辑
    const { username, password } = req.body;
    // 连接外部数据库进行验证
    // ...
  }
}
```

## 部署命令

### Web前端部署
```bash
cd web
npm run build
vercel --prod
```

### Admin后台部署  
```bash
cd admin
npm run build:prod
vercel --prod
```

## 注意事项

1. **数据库连接**: 需要使用云数据库服务
2. **CORS配置**: 后端需要配置跨域访问
3. **环境变量**: 确保生产环境变量正确配置
4. **文件上传**: 可能需要使用云存储服务（如AWS S3）
5. **WebSocket**: Vercel不支持长连接，需要外部服务

## 成本估算

- **Vercel**: 免费层可部署前端
- **Railway**: $5/月起
- **PlanetScale**: 免费层5GB存储
- **总成本**: 约$5-10/月
