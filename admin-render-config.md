# ⚙️ 管理后台 Render 部署配置

## 部署步骤

### 1. 创建Static Site
- **Name**: `xanadu-admin`
- **Build Command**: `cd admin && npm install --legacy-peer-deps && NODE_OPTIONS="--openssl-legacy-provider" npm run build:prod`
- **Publish Directory**: `admin/dist`

### 2. 环境变量
```
NODE_ENV=production
VUE_APP_BASE_API=https://xanadu-backend.onrender.com/api/v1
```

### 3. 特殊配置说明
- 使用 `--legacy-peer-deps` 解决依赖冲突
- 使用 `NODE_OPTIONS="--openssl-legacy-provider"` 支持旧版OpenSSL
- Vue2项目需要特殊的构建配置

预计构建时间: 5-8分钟
