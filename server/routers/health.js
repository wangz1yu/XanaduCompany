const Router = require('koa-router');
const { sequelize } = require('../config/connect');
const router = new Router();

// 健康检查端点
router.get('/health', async (ctx) => {
  ctx.body = {
    status: 'ok',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  };
});

// API版本信息
router.get('/api/v1/health', async (ctx) => {
  let databaseStatus = 'disconnected';
  try {
    await sequelize.authenticate();
    databaseStatus = 'connected';
  } catch (error) {
    console.error('Database connection error:', error);
    databaseStatus = 'error';
  }
  
  ctx.body = {
    status: 'ok',
    version: '1.0.1',
    timestamp: new Date().toISOString(),
    database: databaseStatus,
    uptime: process.uptime()
  };
});

module.exports = router;
