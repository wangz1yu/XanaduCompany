# 🗄️ Render PostgreSQL 数据库初始化指南

## 步骤1: 访问数据库控制台

1. 在Render Dashboard中找到您的PostgreSQL数据库
2. 点击数据库名称进入详情页
3. 点击 **"Connect"** 或 **"Console"** 按钮

## 步骤2: 执行初始化SQL

在数据库控制台中，粘贴并执行以下SQL文件的内容：

**文件位置**: `/server/init/initial_data_postgres.sql`

## 步骤3: 验证数据导入

执行以下查询验证数据是否正确导入：

```sql
-- 检查表是否创建成功
\dt

-- 检查用户数据
SELECT id, username, name, role_id FROM aw_accounts;

-- 检查角色数据  
SELECT * FROM aw_roles;

-- 检查新闻数据
SELECT id, title, author FROM aw_news LIMIT 3;
```

## 步骤4: 确认登录凭据

默认用户账户：
- **管理员**: admin / 654321
- **游客**: youke / a123456  
- **编辑**: editor / [原密码]

## 💡 提示

- 如果SQL执行出错，可能是表已存在，可以先DROP再CREATE
- 数据库初始化只需要执行一次
- 完成后可以通过API测试数据访问

## 🔗 API测试端点

数据导入完成后，可以测试：
- `GET /api/v1/health` - 健康检查
- `GET /api/v1/web/jobs` - 职位列表
- `GET /api/v1/web/news` - 新闻列表
