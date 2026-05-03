#!/bin/bash
set -e

echo "Downloading libstdc++.6.0.9.tbd..."

URL="https://www.xuanr.cn/iosoldlib/libstdc%2B%2B.6.0.9.tbd"

SDK_PATHS=(
    "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/"
    "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/"
)

for SDK_PATH in "${SDK_PATHS[@]}"; do
    if [ -d "$SDK_PATH" ]; then
        curl -L -o "${SDK_PATH}libstdc++.6.0.9.tbd" "$URL" --retry 3 --retry-delay 2
        echo "Downloaded to $SDK_PATH"
    fi
done

echo "Installation complete!"
