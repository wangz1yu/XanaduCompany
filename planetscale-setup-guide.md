# 🗄️ PlanetScale数据库设置指南

## 步骤1: 创建PlanetScale账户和数据库

1. 访问 [PlanetScale](https://planetscale.com)
2. 使用GitHub账户注册/登录
3. 点击 **"Create database"**
4. 配置数据库:
   - **Database name**: `xanadu-company`
   - **Region**: `AWS us-east-1` (推荐，或选择最近的地区)
   - **Plan**: `Hobby` (免费)

## 步骤2: 获取连接信息

1. 进入数据库详情页
2. 点击 **"Connect"** 按钮
3. 选择 **"Node.js"** 连接方式
4. 复制连接信息，格式类似：
   ```
   Host: aws.connect.psdb.cloud
   Username: xxxxxxxxx
   Password: pscale_pw_xxxxxxxxx
   Database: xanadu-company
   Port: 3306
   ```

## 步骤3: 在Render设置环境变量

回到Render Dashboard，在Environment Variables中添加：

```
NODE_ENV = production
PORT = 10000
DB_HOST = aws.connect.psdb.cloud
DB_PORT = 3306
DB_NAME = xanadu-company
DB_USER = [从PlanetScale复制的用户名]
DB_PASSWORD = [从PlanetScale复制的密码]
```

## 步骤4: 导入初始数据

### 方法1: 使用PlanetScale CLI (推荐)
```bash
# 安装PlanetScale CLI
npm install -g @planetscale/cli

# 登录
pscale auth login

# 连接到数据库
pscale shell xanadu-company main

# 在shell中执行SQL文件内容
```

### 方法2: 使用PlanetScale Console
1. 在PlanetScale Dashboard中点击 **"Console"**
2. 手动复制粘贴 `/server/init/initial_data.sql` 的内容
3. 执行SQL语句

## 步骤5: 测试连接

部署完成后，访问以下URL测试API:
- `https://你的render应用名.onrender.com/api/v1/web/jobs` (测试数据库连接)

## 📊 PlanetScale免费套餐

- **存储**: 5GB
- **读取**: 10亿行/月
- **写入**: 1000万行/月
- **连接**: 1000个并发连接
- **备份**: 30天

对于demo项目来说完全够用！

## 🔧 故障排除

如果连接失败：
1. 检查PlanetScale数据库状态是否为 "Ready"
2. 确认连接信息复制正确
3. 检查环境变量拼写
4. 查看Render的Deploy Logs

## 💡 重要提示

- PlanetScale使用SSL连接，已在dbinfo.js中配置
- 数据库创建后可能需要1-2分钟才能就绪
- 确保选择正确的数据库分支 (通常是"main")
