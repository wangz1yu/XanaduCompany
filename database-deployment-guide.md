# 🌟 云数据库部署指南

## 选项1: PlanetScale (推荐)
PlanetScale是一个无服务器的MySQL平台，免费套餐非常慷慨。

### 步骤：
1. 访问 https://planetscale.com/
2. 使用GitHub账户注册/登录
3. 创建新数据库:
   - 数据库名: `xanadu-company`
   - 地区: 选择离用户最近的地区

4. 创建数据库后，获取连接字符串:
   ```bash
   # 格式类似:
   mysql://username:password@host:port/database?sslaccept=strict
   ```

5. 导入初始数据:
   - 在PlanetScale控制台中，可以使用"Console"功能
   - 或者使用MySQL客户端连接后执行 `/server/init/initial_data.sql`

### 免费套餐限制:
- 1个数据库
- 1GB存储
- 10亿行读取/月
- 1000万行写入/月

## 选项2: Supabase
Supabase提供免费的PostgreSQL数据库。

### 步骤：
1. 访问 https://supabase.com/
2. 创建新项目
3. 获取数据库URL
4. 需要将SQL语法从MySQL转换为PostgreSQL

### 免费套餐：
- 2个项目
- 500MB数据库空间
- 实时数据库功能

## 选项3: Railway PostgreSQL (如果账户可用)
如果Railway账户恢复，可以使用Railway的免费PostgreSQL。

## 配置步骤

### 1. 获取数据库URL后，更新后端配置
更新 `server/config/dbinfo.js`:

```javascript
// 云数据库配置
const config = {
  development: {
    dialect: 'mysql', // 或 'postgres'
    host: process.env.DB_HOST,
    port: process.env.DB_PORT || 3306,
    database: process.env.DB_NAME,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false
      }
    }
  }
}
```

### 2. 在Render中设置环境变量
- `DB_HOST`: 数据库主机地址
- `DB_PORT`: 端口号
- `DB_NAME`: 数据库名
- `DB_USER`: 用户名
- `DB_PASSWORD`: 密码
- `NODE_ENV`: production

### 3. 更新前端API地址
部署完成后，需要更新前端配置中的API基础URL为Render提供的URL。

## 💡 建议
推荐使用PlanetScale，因为：
1. 免费套餐更慷慨
2. 原生MySQL兼容
3. 无需修改现有SQL
4. 自动扩展
5. 内置分支功能
