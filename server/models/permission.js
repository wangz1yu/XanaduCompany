const {
  sequelize,
  DataTypes
} = require('../config/connect')
const Permission = sequelize.define(
  'aw_permission',
  {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
    },
    permission_name: {
      type: DataTypes.STRING,
      allowNull: false,
      comment: '权限名称'
    },
    permission_key:{
      type: DataTypes.STRING,
      allowNull: false,
      comment: '权限标识'
    }
  },
  {
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at'
  }
  // {
  //   tableName: 'account'
  // }
)

// Account.sync({force:true}) // 是否自动创建表

module.exports = Permission


