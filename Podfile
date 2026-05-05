# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'  # 👈 建议取消注释，明确指定平台

target 'NJOceanHeart' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  
 	pod 'BaiduMapKit','3.3.1' #百度地图SDK
 	pod 'AFNetworking'
 	pod 'MJRefresh'
	pod 'Masonry'
#	pod 'RongCloudIM/CallLib'
#	pod 'RongCloudIM/CallKit'
    pod 'YUSegment'
    pod 'UICKeyChainStore'
    pod 'RongCloudIM/IMLib'
    pod 'RongCloudIM/IMKit','~> 5.1.3'
#    pod 'RongCloudIM/RedPacket','2.8.22'
    pod 'EBForeNotification'
#    pod 'BRPickerView'
    pod 'IQKeyboardManager'
    pod 'JPush'
    
#    20260504 modify,解决需要去除的问题
#    # 主模块(必须)
#    pod 'ShareSDK3'
#    # Mob 公共库(必须) 如果同时集成SMSSDK iOS2.0:可看此注意事项：http://bbs.mob.com/thread-20051-1-1.html
#    pod 'MOBFoundation'
#    # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
#    pod 'ShareSDK3/ShareSDKUI'
#    # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
#    pod 'ShareSDK3/ShareSDKPlatforms/QQ'
#    pod 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
#    pod 'ShareSDK3/ShareSDKPlatforms/WeChat'
#    pod 'ShareSDK3/ShareSDKExtension'
    
    pod 'mob_sharesdk'
    pod 'mob_sharesdk/ShareSDKUI'
    # pod 'mob_sharesdk/ShareSDKPlatforms/QQ'
    pod 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
    # pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'
    pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull'
    pod 'mob_sharesdk/ShareSDKConfigFile'
    pod 'mob_sharesdk/ShareSDKRestoreScene'
    pod 'mob_sharesdk/ShareSDKExtension'
    
    
#    pod 'Pgyer'
#    pod 'PgyUpdate'
#    pod 'TFHpple'
  # Pods for NJOceanHeart
end

# use Xcode cloud
post_install do |installer|
  # 找到 AFNetworking 库的目录
  afnetworking_dir = installer.sandbox.pod_dir('AFNetworking')
  
  if afnetworking_dir && Dir.exist?(afnetworking_dir)
    # 查找所有包含问题头文件引用的 .m 文件并自动注释
    Dir.glob("#{afnetworking_dir}/**/*.m") do |file_path|
      text = File.read(file_path)
      # 使用正则表达式替换包含 netinet6/in6.h 的 #import 行
      new_text = text.gsub(/^#import\s+<netinet6\/in6\.h>/, '// #import <netinet6/in6.h>')
      if text != new_text
        File.write(file_path, new_text)
        puts "✓ 已修复 AFNetworking 文件: #{file_path}"
      end
    end
  end

  # 修复：移除所有 -lstdc++ 链接标志（已修复数组/字符串兼容问题）
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # 处理 OTHER_LDFLAGS，兼容字符串和数组两种情况
      ldflags = config.build_settings['OTHER_LDFLAGS']
      if ldflags
        # 如果是字符串，先转换为数组
        flags_array = ldflags.is_a?(String) ? ldflags.split : ldflags.dup
        
        # 过滤掉所有包含 stdc++ 的标志
        filtered_flags = flags_array.reject { |flag| flag.to_s.include?('stdc++') }
        
        # 将结果存回去（保持原有类型，但通常 CocoaPods 期望数组）
        config.build_settings['OTHER_LDFLAGS'] = filtered_flags
      end
      
      # 强制 C++ 标准库为 libc++
      config.build_settings['CLANG_CXX_LIBRARY'] = 'libc++'
    end
  end
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # 修复 MinimumOSVersion 错误
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      # 关闭所有库的 Bitcode
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end


end
