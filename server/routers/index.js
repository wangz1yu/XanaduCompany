const Router = require('koa-router')
const router = new Router({
  prefix: '/api/v1',
})

const web = require('./web/webapi')
const admin = require('./admin/admin')
const health = require('./health')

// 健康检查路由（无前缀）
const healthRouter = new Router()
healthRouter.use(health.routes(), health.allowedMethods())

router.use('/web', web.routes(), web.allowedMethods())
router.use('/admin', admin.routes(), admin.allowedMethods())

module.exports = router
