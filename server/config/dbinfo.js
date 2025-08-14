const config = {
    // 支持Render DATABASE_URL或独立环境变量
    ...(process.env.DATABASE_URL ? {
        url: process.env.DATABASE_URL,
        dialect: "postgres"
    } : {
        database: process.env.DB_NAME || "Xanadu", 
        username: process.env.DB_USER || "root", 
        password: process.env.DB_PASSWORD || "12345678", 
        host: process.env.DB_HOST || "localhost", 
        port: process.env.DB_PORT || "3306", 
        dialect: process.env.DB_DIALECT || "mysql"
    }),
    // logging: true, // 是否启用日志
    dialectOptions: process.env.NODE_ENV === 'production' ? {
        ssl: {
            require: true,
            rejectUnauthorized: false
        }
    } : {}
}
module.exports = config
// sequelize-auto -h 'localhost' -d 'xanadu' -u 'root' -x '123456' -p 3307 -t 'aw_user'
