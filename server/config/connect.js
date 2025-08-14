// 在connect.js文件中,使用sequelize连接数据库
const config = require('./dbinfo') // 引入数据库配置信息
const { Sequelize, DataTypes ,Op} = require("sequelize") // 引入sequelize依赖

// 根据配置创建Sequelize实例
let sequelize;

if (process.env.DATABASE_URL) {
  // 使用DATABASE_URL（Render PostgreSQL）
  sequelize = new Sequelize(process.env.DATABASE_URL, {
    dialect: 'postgres',
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false
      }
    },
    pool: {
      min: 0,
      max: 5,
      idle: 30000,
      acquire: 60000,
    },
    define: {
      underscored: true
    },
    logging: process.env.NODE_ENV === 'development' ? console.log : false
  });
} else {
  // 使用传统配置（本地开发）
  sequelize = new Sequelize(
    config.database,
    config.username,
    config.password,
    {
      dialect: config.dialect,
      dialectOptions: config.dialectOptions || {
        dateStrings: true,
        typeCast: true
      },
      host: config.host,
      port: config.port,
      logging: config.logging,
      pool: {
        min: 0,
        max: 5,
        idle: 30000,
        acquire: 60000,
      },
      define: {
        underscored: true
      },
      timezone: '+08:00'
    }
  );
}

module.exports = {
  sequelize,// 将sequelize暴露出接口方便Model调用
  DataTypes,
  Op
}


