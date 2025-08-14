# 🚀 Render部署完整指南

## 步骤1: 在Render创建Web Service

1. 访问 [Render Dashboard](https://dashboard.render.com)
2. 点击 **"New +"** → **"Web Service"**
3. 连接GitHub仓库:
   - 选择 `wangz1yu/XanaduCompany`
   - 分支: `vue3`

## 步骤2: 配置Service设置

### 基础配置
- **Name**: `xanadu-backend`
- **Environment**: `Node`
- **Region**: 选择最近的地区 (Singapore推荐)
- **Branch**: `vue3`

### 构建和部署设置
- **Build Command**: `cd server && npm install`
- **Start Command**: `cd server && npm start`

### 环境变量 (点击 "Advanced" 设置)
```
NODE_ENV = production
PORT = 10000
DB_HOST = [待设置 - PlanetScale数据库]
DB_PORT = 3306
DB_NAME = [待设置]
DB_USER = [待设置]
DB_PASSWORD = [待设置]
```

## 步骤3: 部署完成后的配置

部署成功后，Render会提供一个URL，类似:
`https://xanadu-backend.onrender.com`

## 步骤4: 设置数据库 (PlanetScale)

### 4.1 创建PlanetScale数据库
1. 访问 [PlanetScale](https://planetscale.com)
2. 创建新数据库: `xanadu-company`
3. 获取连接信息

### 4.2 更新Render环境变量
在Render Dashboard中更新环境变量:
- `DB_HOST`: PlanetScale提供的主机地址
- `DB_NAME`: 数据库名称
- `DB_USER`: 用户名
- `DB_PASSWORD`: 密码

### 4.3 导入数据
在PlanetScale Console中执行 `/server/init/initial_data.sql`

## 步骤5: 更新前端API配置

部署完成后，需要更新前端应用中的API地址:

### Web前端 (Vercel重新部署)
```bash
# 在 web/.env.production 中更新
VUE_APP_BASE_URL=https://xanadu-backend.onrender.com
```

### Admin后台 (Vercel重新部署)
```bash
# 在 admin/.env.production 中更新  
VUE_APP_BASE_API=https://xanadu-backend.onrender.com/api/v1
```

## 步骤6: 测试部署

1. 访问 `https://xanadu-backend.onrender.com/api/v1/health` 检查API
2. 重新部署前端应用到Vercel
3. 测试完整的前后端功能

## 💡 重要提示

- Render免费版服务15分钟无活动后会休眠
- 首次访问可能需要等待几秒钟启动
- 部署过程大约需要3-5分钟
- 确保所有环境变量正确配置

## 🚨 故障排除

如果部署失败，检查:
1. Build logs中的错误信息
2. 环境变量是否正确设置
3. package.json中的scripts配置
4. Node.js版本兼容性

## 📞 获取帮助

部署过程中如有问题，可以:
1. 查看Render的Build Logs
2. 检查Environment Variables设置
3. 确认GitHub仓库权限
