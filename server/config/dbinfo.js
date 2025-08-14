const config = {
    database: process.env.DB_NAME || "Xanadu", // 数据库名称
    username: process.env.DB_USER || "root", // 用户名
    password: process.env.DB_PASSWORD || "12345678", // 密码
    host: process.env.DB_HOST || "localhost", // 主机地址
    port: process.env.DB_PORT || "3306", // 端口号
    dialect: "mysql", //数据库类型，支持: 'mysql', 'sqlite', 'postgres', 'mssql'
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
