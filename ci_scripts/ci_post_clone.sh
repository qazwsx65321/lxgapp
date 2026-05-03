#!/bin/bash
set -e

echo "Setting up libstdc++.6.0.9.tbd in user directory..."

# 获取项目根目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SOURCE_FILE="$PROJECT_ROOT/ci_libs/libstdc++.6.0.9.tbd"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Error: Source file not found at: $SOURCE_FILE"
    exit 1
fi

echo "✅ Found source file: $SOURCE_FILE"

# 创建用户目录
USER_LIB_DIR="$HOME/lib"
mkdir -p "$USER_LIB_DIR"

# 复制文件到用户目录
cp "$SOURCE_FILE" "$USER_LIB_DIR/libstdc++.6.0.9.tbd"
echo "✅ Copied to user directory: $USER_LIB_DIR"

# 检查并修改项目配置，添加库搜索路径
echo "Modifying project to add library search path..."

# 查找 project.pbxproj 文件
PBXPROJ="$PROJECT_ROOT/NJOceanHeart.xcodeproj/project.pbxproj"

if [ -f "$PBXPROJ" ]; then
    # 备份原文件
    cp "$PBXPROJ" "$PBXPROJ.bak"
    
    # 添加 LIBRARY_SEARCH_PATHS（如果不存在）
    if ! grep -q "LIBRARY_SEARCH_PATHS.*$USER_LIB_DIR" "$PBXPROJ"; then
        # 在 Release 配置中添加
        sed -i '' "s/LIBRARY_SEARCH_PATHS = (/LIBRARY_SEARCH_PATHS = ($USER_LIB_DIR /g" "$PBXPROJ"
        echo "✅ Added library search path to project"
    fi
fi

echo "🎉 Setup complete!"
