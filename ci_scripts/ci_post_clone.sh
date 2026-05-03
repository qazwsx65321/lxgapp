#!/bin/bash
set -e

echo "Setting up libstdc++.6.0.9.tbd..."

# 获取项目根目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SOURCE_FILE="$PROJECT_ROOT/ci_libs/libstdc++.6.0.9.tbd"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ Error: Source file not found at: $SOURCE_FILE"
    exit 1
fi

echo "✅ Found source file: $SOURCE_FILE"

# 创建用户库目录
USER_LIB_DIR="$HOME/lib"
mkdir -p "$USER_LIB_DIR"

# 复制文件
cp "$SOURCE_FILE" "$USER_LIB_DIR/libstdc++.6.0.9.tbd"
echo "✅ Copied to: $USER_LIB_DIR/libstdc++.6.0.9.tbd"

# 创建一个 xcconfig 文件，添加库搜索路径
cat > "$PROJECT_ROOT/xcodecloud.xcconfig" << EOF
// Xcode Cloud 专用配置
LIBRARY_SEARCH_PATHS = \$(inherited) $USER_LIB_DIR
OTHER_LDFLAGS = \$(inherited) -lstdc++.6.0.9
EOF

echo "✅ Created xcodecloud.xcconfig"

# 修改项目配置，使用这个 xcconfig
echo "📝 Please configure your Xcode Cloud workflow to use xcodecloud.xcconfig"
echo "   Add -xcconfig $PROJECT_ROOT/xcodecloud.xcconfig to xcodebuild arguments"

echo "🎉 Setup complete!"
