#!/bin/bash
echo "Copying libstdc++.6.0.9.tbd from local repo..."

SDK_PATHS=(
    "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/"
    "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/"
)

for SDK_PATH in "${SDK_PATHS[@]}"; do
    if [ -d "$SDK_PATH" ]; then
        cp "$CI_WORKSPACE/ci_libs/libstdc++.6.0.9.tbd" "${SDK_PATH}libstdc++.6.0.9.tbd"
        echo " Installed to $SDK_PATH"
    fi
done
