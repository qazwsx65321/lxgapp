#!/bin/bash
set -e

echo "Copying libstdc++.6.0.9.tbd from local repo..."

# 获取脚本所在目录的父目录（项目根目录）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SOURCE_FILE="$PROJECT_ROOT/ci_libs/libstdc++.6.0.9.tbd"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file not found at: $SOURCE_FILE"
    exit 1
fi

echo "Found source file: $SOURCE_FILE"

SDK_PATHS=(
    "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/"
    "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/"
)

for SDK_PATH in "${SDK_PATHS[@]}"; do
    if [ -d "$SDK_PATH" ]; then
        cp "$SOURCE_FILE" "${SDK_PATH}libstdc++.6.0.9.tbd"
        echo "Installed to $SDK_PATH"
    fi
done

echo "Installation complete!"
