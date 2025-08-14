# 🗄️ Render数据库创建指南

## 📋 Render PostgreSQL数据库设置

### 步骤1: 创建数据库
1. 在Render Dashboard中点击 **"New +"**
2. 选择 **"PostgreSQL"**
3. 配置数据库:
   - **Name**: `xanadu-database`
   - **Database**: `xanadu`
   - **User**: `xanadu`
   - **Region**: 选择与后端相同的地区
   - **PostgreSQL Version**: 使用默认最新版本
   - **Plan**: 选择 **"Free"** (1GB存储)

### 步骤2: 等待创建完成
- 数据库创建需要2-3分钟
- 状态会从 "Creating" 变为 "Available"

### 步骤3: 获取连接信息
创建完成后，在数据库详情页面可以看到：
- **Internal Database URL**: 用于同平台服务连接
- **External Database URL**: 用于外部连接
- **Connection Parameters**: 主机、端口、用户名、密码等

## ⚠️ 重要：数据库类型适配

由于原项目使用MySQL，而Render免费版只提供PostgreSQL，需要进行适配：

### 方案1: 修改为PostgreSQL (推荐)
修改后端配置以支持PostgreSQL

### 方案2: 继续使用PlanetScale MySQL
保持原有MySQL兼容性

## 🔧 如果选择Render PostgreSQL

需要修改以下文件以支持PostgreSQL：

### 1. 更新package.json依赖
```json
{
  "dependencies": {
    "pg": "^8.8.0",
    "pg-hstore": "^2.3.4"
  }
}
```

### 2. 更新数据库配置
```javascript
// server/config/dbinfo.js
const config = {
    database: process.env.DATABASE_URL || process.env.DB_NAME,
    dialect: "postgres", // 改为postgres
    dialectOptions: process.env.NODE_ENV === 'production' ? {
        ssl: {
            require: true,
            rejectUnauthorized: false
        }
    } : {}
}
```

### 3. SQL语法适配
MySQL → PostgreSQL 需要调整的语法：
- `AUTO_INCREMENT` → `SERIAL`
- `TINYINT(1)` → `BOOLEAN`
- 字符串函数差异等

## 💡 建议选择

### 🎯 最简单方案：继续使用PlanetScale MySQL
- ✅ 无需修改现有代码
- ✅ 保持MySQL兼容性
- ✅ 5GB免费存储 vs 1GB PostgreSQL
- ✅ 专业MySQL云服务

### 如果您想继续PlanetScale：
1. 取消Render数据库创建
2. 访问 https://planetscale.com
3. 创建MySQL数据库
4. 无需修改代码

## 🤔 您的选择

请告诉我您想：
1. **继续Render PostgreSQL** (需要代码适配)
2. **改用PlanetScale MySQL** (无需修改代码)

我会根据您的选择提供相应的配置指导！
