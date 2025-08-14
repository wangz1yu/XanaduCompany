#!/bin/bash

echo "🔧 修复Sequelize模型PostgreSQL兼容性..."

# 查找所有模型文件中的问题类型定义
echo "查找需要修复的文件..."

# 修复 INTEGER(11) -> INTEGER
find /workspaces/XanaduCompany/server/models -name "*.js" -exec sed -i 's/DataTypes\.INTEGER(11)/DataTypes.INTEGER/g' {} \;
find /workspaces/XanaduCompany/server/models -name "*.js" -exec sed -i 's/DataTypes\.INTEGER(10)/DataTypes.INTEGER/g' {} \;
find /workspaces/XanaduCompany/server/models -name "*.js" -exec sed -i 's/DataTypes\.INTEGER(20)/DataTypes.BIGINT/g' {} \;

# 修复 TINYINT(1) -> BOOLEAN (对于状态字段)
find /workspaces/XanaduCompany/server/models -name "*.js" -exec sed -i 's/DataTypes\.TINYINT(1)/DataTypes.BOOLEAN/g' {} \;

# 修复 BIGINT(20) -> BIGINT
find /workspaces/XanaduCompany/server/models -name "*.js" -exec sed -i 's/DataTypes\.BIGINT(20)/DataTypes.BIGINT/g' {} \;

# 修复 SMALLINT(6) -> SMALLINT
find /workspaces/XanaduCompany/server/models -name "*.js" -exec sed -i 's/DataTypes\.SMALLINT(6)/DataTypes.SMALLINT/g' {} \;

echo "✅ 模型文件已修复!"
echo "修复内容:"
echo "  - INTEGER(11) → INTEGER"
echo "  - TINYINT(1) → BOOLEAN" 
echo "  - BIGINT(20) → BIGINT"
echo "  - SMALLINT(6) → SMALLINT"
