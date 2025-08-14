
const { sequelize, DataTypes } = require("../config/connect") // 引入相关依赖以及数据库
const getDataTypes = require("../config/dataTypes");

const Types = getDataTypes(sequelize);

const Account = sequelize.define(
    "aw_accounts", // 数据库中生成的表名(最终会自动在末尾添加s,因此最终数据库中生自动成表名为accounts
    { // 表字段信息配置
      id: Types.PRIMARY_KEY,
      name: {
        type: Types.STRING, // 字段类型
        allowNull: true, // 是否允许为空
        comment: '姓名'
      },
      username: {
        type: Types.STRING, // 字段类型
        allowNull: false, // 是否允许为空
      },
      password: {
        type: Types.STRING, // 字段类型
        allowNull: false, // 是否允许为空
      },
      avatar:{
        type: Types.STRING_1500, // 字段类型
        allowNull: true, // 是否允许为空
        defaultValue: process.env.NODE_ENV === 'production' 
          ? 'https://xanadu-backend.onrender.com/upload/20210612/16234847490027294.png'
          : 'http://localhost:3000/upload/20210612/16234847490027294.png'
      },
      sex: {
        type: Types.STRING, // 字段类型
        allowNull: true, // 是否允许为空
        comment: '性别'
      },
      department: {
        type: Types.STRING, // 字段类型
        allowNull: true, // 是否允许为空
        comment: '部门'
      },
      location: {
        type: Types.STRING, // 字段类型
        allowNull: true, // 是否允许为空
        comment: '位置'
      },
      introduction:{
        type: Types.STRING, // 字段类型
        allowNull: true, // 是否允许为空
        defaultValue:'个人介绍'
      }
    },
    {
      timestamps: true, // 是否自动在数据表中添加数据操作时间
    }
    // {
    //   tableName: 'account'
    // }
)

// Account.sync({force:true}) // 是否自动创建表

module.exports = Account
