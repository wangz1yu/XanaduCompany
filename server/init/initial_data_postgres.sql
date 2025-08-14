-- PostgreSQL版本的初始化数据
-- 适配自MySQL的initial_data.sql

-- 创建数据库（在Render中数据库已存在，此行可选）
-- CREATE DATABASE xanadu;

-- 设置时区和字符编码
SET timezone = 'UTC';
SET client_encoding = 'UTF8';

-- 删除存在的表（按依赖关系顺序）
DROP TABLE IF EXISTS aw_accounts CASCADE;
DROP TABLE IF EXISTS aw_roles CASCADE;
DROP TABLE IF EXISTS aw_permissions CASCADE;
DROP TABLE IF EXISTS aw_role_permissions CASCADE;
DROP TABLE IF EXISTS aw_menu_lists CASCADE;
DROP TABLE IF EXISTS aw_role_menu_lists CASCADE;
DROP TABLE IF EXISTS aw_jobs CASCADE;
DROP TABLE IF EXISTS aw_job_categories CASCADE;
DROP TABLE IF EXISTS aw_recruit_types CASCADE;
DROP TABLE IF EXISTS aw_city_infos CASCADE;
DROP TABLE IF EXISTS aw_news CASCADE;
DROP TABLE IF EXISTS aw_news_types CASCADE;
DROP TABLE IF EXISTS aw_recommend_news CASCADE;
DROP TABLE IF EXISTS aw_products CASCADE;

-- 创建角色表
CREATE TABLE aw_roles (
  id SERIAL PRIMARY KEY,
  role_name VARCHAR(255) NOT NULL,
  role_key VARCHAR(255) NOT NULL,
  status INTEGER DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建权限表
CREATE TABLE aw_permissions (
  id SERIAL PRIMARY KEY,
  permission_name VARCHAR(255) NOT NULL,
  permission_key VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建角色权限关联表
CREATE TABLE aw_role_permissions (
  id SERIAL PRIMARY KEY,
  role_id INTEGER REFERENCES aw_roles(id) ON DELETE CASCADE,
  permission_id INTEGER REFERENCES aw_permissions(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建菜单表
CREATE TABLE aw_menu_lists (
  id SERIAL PRIMARY KEY,
  menu_name VARCHAR(255) NOT NULL,
  menu_url VARCHAR(255),
  menu_icon VARCHAR(255),
  parent_id INTEGER DEFAULT 0,
  sort_order INTEGER DEFAULT 0,
  status INTEGER DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建角色菜单关联表
CREATE TABLE aw_role_menu_lists (
  id SERIAL PRIMARY KEY,
  role_id INTEGER REFERENCES aw_roles(id) ON DELETE CASCADE,
  menu_id INTEGER REFERENCES aw_menu_lists(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建账户表
CREATE TABLE aw_accounts (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
  role_id INTEGER REFERENCES aw_roles(id) ON DELETE SET NULL,
  avatar VARCHAR(1500) DEFAULT 'https://xanadu-backend.onrender.com/upload/20210612/16234847490027294.png',
  introduction VARCHAR(255) DEFAULT '个人介绍',
  name VARCHAR(255),
  sex VARCHAR(255),
  department VARCHAR(255),
  location VARCHAR(255)
);

-- 创建城市信息表
CREATE TABLE aw_city_infos (
  id SERIAL PRIMARY KEY,
  city_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建招聘类型表
CREATE TABLE aw_recruit_types (
  id SERIAL PRIMARY KEY,
  type_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建职位分类表
CREATE TABLE aw_job_categories (
  id SERIAL PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建职位表
CREATE TABLE aw_jobs (
  id SERIAL PRIMARY KEY,
  job_title VARCHAR(255) NOT NULL,
  job_description TEXT,
  salary_range VARCHAR(255),
  work_location VARCHAR(255),
  requirements TEXT,
  job_category_id INTEGER REFERENCES aw_job_categories(id),
  recruit_type_id INTEGER REFERENCES aw_recruit_types(id),
  city_id INTEGER REFERENCES aw_city_infos(id),
  status INTEGER DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建新闻类型表
CREATE TABLE aw_news_types (
  id SERIAL PRIMARY KEY,
  type_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建新闻表
CREATE TABLE aw_news (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  summary VARCHAR(500),
  cover_image VARCHAR(1500),
  author VARCHAR(255),
  news_type_id INTEGER REFERENCES aw_news_types(id),
  view_count INTEGER DEFAULT 0,
  status INTEGER DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建推荐新闻表
CREATE TABLE aw_recommend_news (
  id SERIAL PRIMARY KEY,
  news_id INTEGER REFERENCES aw_news(id) ON DELETE CASCADE,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 创建产品表
CREATE TABLE aw_products (
  id SERIAL PRIMARY KEY,
  product_name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2),
  cover_image VARCHAR(1500),
  status INTEGER DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 插入基础数据

-- 插入角色数据
INSERT INTO aw_roles (role_name, role_key, status) VALUES
('超级管理员', 'admin', 1),
('编辑员', 'editor', 1),
('普通用户', 'user', 1);

-- 插入权限数据
INSERT INTO aw_permissions (permission_name, permission_key) VALUES
('用户管理', 'user:manage'),
('文章管理', 'article:manage'),
('系统管理', 'system:manage');

-- 插入角色权限关联
INSERT INTO aw_role_permissions (role_id, permission_id) VALUES
(1, 1), (1, 2), (1, 3),  -- 超级管理员拥有所有权限
(2, 2),                   -- 编辑员拥有文章管理权限
(3, 2);                   -- 普通用户拥有文章查看权限

-- 插入菜单数据
INSERT INTO aw_menu_lists (menu_name, menu_url, menu_icon, parent_id, sort_order) VALUES
('首页', '/dashboard', 'el-icon-s-home', 0, 1),
('用户管理', '/user', 'el-icon-user', 0, 2),
('内容管理', '/content', 'el-icon-document', 0, 3),
('系统管理', '/system', 'el-icon-setting', 0, 4);

-- 插入用户数据（密码都是bcrypt加密的）
INSERT INTO aw_accounts (username, password, role_id, avatar, introduction, name, sex, department, location) VALUES
('admin', '$2b$10$lHM2cWr9x.kcHIbe9aDgTeaU10RuKaoud8Zowm07OyIXJhL6N0bvu', 1, 'https://xanadu-backend.onrender.com/upload/20210612/16234846156416317.png', '超级管理员', '张三', '男', '技术一部', '浙江-杭州'),
('youke', '$2b$10$cX52DV7xdVi3ONXGC1RsXeM8EsCtGQFwFqRYaSW2mDE6fjEhkRadK', 3, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', '游客，普通权限', '王五', '男', '运营二部', '北京'),
('editor', '$2b$10$BmRzMNTLMocyHqzHNutBQuZJJ6j/S0mkdgK/Ffe7E/jiVovFh9ezi', 2, 'https://xanadu-backend.onrender.com/upload/2021064/16228135311306915.jpg', '文章编辑员', '李四', '男', '运营一部', '北京');

-- 插入城市数据
INSERT INTO aw_city_infos (city_name) VALUES
('北京'), ('上海'), ('广州'), ('深圳'), ('杭州'), ('成都'), ('武汉'), ('西安');

-- 插入招聘类型数据
INSERT INTO aw_recruit_types (type_name) VALUES
('全职'), ('兼职'), ('实习'), ('外包');

-- 插入职位分类数据
INSERT INTO aw_job_categories (category_name) VALUES
('技术开发'), ('产品设计'), ('市场运营'), ('销售'), ('人力资源'), ('财务');

-- 插入示例职位数据
INSERT INTO aw_jobs (job_title, job_description, salary_range, work_location, requirements, job_category_id, recruit_type_id, city_id) VALUES
('前端工程师', '负责前端页面开发和维护', '15K-25K', '北京', '熟悉Vue.js、React等前端框架', 1, 1, 1),
('后端工程师', '负责后端API开发和维护', '18K-30K', '上海', '熟悉Node.js、Python、Java等', 1, 1, 2),
('产品经理', '负责产品规划和需求分析', '20K-35K', '深圳', '有互联网产品经验', 2, 1, 4);

-- 插入新闻类型数据
INSERT INTO aw_news_types (type_name) VALUES
('公司新闻'), ('行业动态'), ('技术分享'), ('产品更新');

-- 插入示例新闻数据
INSERT INTO aw_news (title, content, summary, author, news_type_id) VALUES
('欢迎来到Xanadu公司', '这是一篇欢迎新员工的文章...', '欢迎加入我们的大家庭', '管理员', 1),
('前端技术分享', 'Vue3的新特性介绍...', '学习Vue3的最新特性', '技术团队', 3),
('产品更新公告', '我们的产品迎来了重大更新...', '产品功能全面升级', '产品团队', 4);

-- 插入示例产品数据
INSERT INTO aw_products (product_name, description, price) VALUES
('企业管理系统', '全方位的企业管理解决方案', 9999.00),
('客户关系系统', '高效的客户关系管理工具', 5999.00),
('数据分析平台', '强大的数据分析和可视化平台', 12999.00);

-- 创建索引以提高查询性能
CREATE INDEX idx_accounts_username ON aw_accounts(username);
CREATE INDEX idx_accounts_role_id ON aw_accounts(role_id);
CREATE INDEX idx_jobs_category_id ON aw_jobs(job_category_id);
CREATE INDEX idx_jobs_city_id ON aw_jobs(city_id);
CREATE INDEX idx_news_type_id ON aw_news(news_type_id);

COMMIT;
