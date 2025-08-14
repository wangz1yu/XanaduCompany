const { DataTypes } = require('sequelize');

// PostgreSQL兼容的数据类型映射
const getDataTypes = (sequelize) => {
  const dialect = sequelize.getDialect();
  
  return {
    // 整数类型 - PostgreSQL不支持长度参数
    INTEGER: dialect === 'postgres' ? DataTypes.INTEGER : DataTypes.INTEGER(11),
    BIGINT: dialect === 'postgres' ? DataTypes.BIGINT : DataTypes.BIGINT(20),
    SMALLINT: dialect === 'postgres' ? DataTypes.SMALLINT : DataTypes.SMALLINT(6),
    
    // 布尔类型 - MySQL用TINYINT(1), PostgreSQL用BOOLEAN
    BOOLEAN: DataTypes.BOOLEAN,
    TINYINT: dialect === 'postgres' ? DataTypes.BOOLEAN : DataTypes.TINYINT(1),
    
    // 字符串类型
    STRING: DataTypes.STRING,
    STRING_500: DataTypes.STRING(500),
    STRING_1500: DataTypes.STRING(1500),
    TEXT: DataTypes.TEXT,
    
    // 其他类型
    DECIMAL: DataTypes.DECIMAL(10, 2),
    DATE: DataTypes.DATE,
    DATETIME: dialect === 'postgres' ? DataTypes.DATE : DataTypes.DATE,
    
    // 自增主键的标准定义
    PRIMARY_KEY: {
      type: dialect === 'postgres' ? DataTypes.INTEGER : DataTypes.INTEGER(11),
      allowNull: false,
      autoIncrement: true,
      primaryKey: true
    }
  };
};

module.exports = getDataTypes;
