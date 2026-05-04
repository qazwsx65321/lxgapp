#!/bin/sh
set -e
set -x

echo "=== 修复版：Xcode Cloud 自动注入 libstdc++.6.0.9 ==="

# 🔥 修复：Xcode Cloud 下正确获取项目根目录
REPO_DIR="/Volumes/workspace/repository"

# 正确的库路径（绝对路径）
LIB_OS="$REPO_DIR/ios_libs/iPhoneOS/libstdc++.6.0.9.tbd"
LIB_SIM="$REPO_DIR/ios_libs/iPhoneSimulator/libstdc++.6.0.9.tbd"

# Xcode 系统目录
DEST_OS="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib"
DEST_SIM="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib"

# 复制真机库
if [ -f "$LIB_OS" ]; then
    echo "✅ 复制真机库到系统目录"
    cp -f "$LIB_OS" "$DEST_OS/"
else
    echo "❌ 找不到真机库: $LIB_OS"
    exit 1
fi

# 复制模拟器库
if [ -f "$LIB_SIM" ]; then
    echo "✅ 复制模拟器库到系统目录"
    cp -f "$LIB_SIM" "$DEST_SIM/"
else
    echo "❌ 找不到模拟器库: $LIB_SIM"
    exit 1
fi

echo "=== 🎉 libstdc++.6.0.9 安装完成，构建可以继续 ==="
