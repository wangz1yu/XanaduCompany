const { sequelize, DataTypes } = require("../config/connect") // 引入相关依赖以及数据库
const MenuList = sequelize.define(
  "aw_menu_list", // 数据库中生成的表名
  { // 表字段信息配置
    id: {
      type: DataTypes.INTEGER, // 字段类型
      allowNull: false, // 是否允许为空
      autoIncrement: true,
      primaryKey: true, // 是否主键
    },
    parent_id:{
      type: DataTypes.INTEGER, // 字段类型
      allowNull: true, // 是否允许为空
      defaultValue: 0,
      comment:'父级ID'
    },
    menu_name: {
      type: DataTypes.STRING, // 字段类型
      allowNull: false, // 是否允许为空
      comment:'菜单名称'
    },
    menu_url: {
      type: DataTypes.STRING, // 字段类型
      allowNull: true, // 是否允许为空
      comment:'菜单URL'
    },
    menu_icon: {
      type: DataTypes.STRING, // 字段类型
      allowNull: true, // 是否允许为空
      comment:'菜单图标'
    },
    sort_order: {
      type: DataTypes.INTEGER, // 字段类型
      allowNull: false, // 是否允许为空
      defaultValue: 0,
      comment:'排序'
    },
    status: {
      type: DataTypes.INTEGER, // 字段类型
      allowNull: false, // 是否允许为空
      defaultValue: 1,
      comment:'状态'
    }
  },
  {
    timestamps: true, // 是否自动在数据表中添加数据操作时间
    createdAt: 'created_at',
    updatedAt: 'updated_at'
  }
)


module.exports = MenuList
