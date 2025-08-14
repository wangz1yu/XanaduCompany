const {
  sequelize,
  DataTypes
} = require('../config/connect') // 引入相关依赖以及数据库
const getDataTypes = require("../config/dataTypes");

const Types = getDataTypes(sequelize);

const Role = sequelize.define(
  'aw_role', // 数据库中生成的表名
  { // 表字段信息配置
    id: Types.PRIMARY_KEY,
    role_name: {
      type: Types.STRING, // 字段类型
      allowNull: false, // 是否允许为空
      comment: '角色名称'
    },
    role_key: {
      type: Types.STRING, // 字段类型
      allowNull: false, // 是否允许为空
      comment: '角色标识'
    },
    status: {
      type: Types.INTEGER, // 字段类型
      allowNull: false, // 是否允许为空
      defaultValue: 1,
      comment: '状态：1/正常'
    }
  },
  {
    timestamps: true, // 是否自动在数据表中添加数据操作时间
    // 不想要 createdAt
    createdAt: 'created_at',
    
    // 想要 updatedAt 但是希望名称叫做 updateTimestamp
    updatedAt: 'updated_at'
  }
  // {
  //   tableName: 'account'
  // }
)

// Account.sync({force:true}) // 是否自动创建表

module.exports = Role
