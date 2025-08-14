const Router = require('koa-router');
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
  ctx.body = {
    status: 'ok',
    version: '1.0.0',
    timestamp: new Date().toISOString(),
    database: ctx.sequelize ? 'connected' : 'disconnected'
  };
});

module.exports = router;
