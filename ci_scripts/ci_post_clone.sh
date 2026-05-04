#!/bin/sh
set -e
set -x

# ==============================
# Xcode Cloud 自动注入 libstdc++.6.0.9 脚本
# 作用：把项目里的旧库复制到 Xcode 系统库目录，解决链接失败
# ==============================

echo "=== 开始安装 libstdc++.6.0.9 到 Xcode Cloud 环境 ==="

# 库文件在你项目里的存放路径（必须和你项目路径一致）
LIB_OS="$SRCROOT/ios_libs/iPhoneOS/libstdc++.6.0.9.tbd"
LIB_SIM="$SRCROOT/ios_libs/iPhoneSimulator/libstdc++.6.0.9.tbd"

# Xcode Cloud 上的系统目标目录（固定路径）
DEST_OS="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib"
DEST_SIM="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib"

# 复制真机库
if [ -f "$LIB_OS" ]; then
    echo "复制真机库到系统目录..."
    cp -f "$LIB_OS" "$DEST_OS/"
else
    echo "错误：找不到真机库 $LIB_OS"
    exit 1
fi

# 复制模拟器库
if [ -f "$LIB_SIM" ]; then
    echo "复制模拟器库到系统目录..."
    cp -f "$LIB_SIM" "$DEST_SIM/"
else
    echo "错误：找不到模拟器库 $LIB_SIM"
    exit 1
fi

echo "=== libstdc++.6.0.9 安装完成 ==="
