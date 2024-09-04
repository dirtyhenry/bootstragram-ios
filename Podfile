source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
platform :ios, '11.0'

target 'bootstragram' do
  use_frameworks!

  # pod 'CocoaLumberjack'
  # pod 'GPUImage'
  pod 'FBSDKCoreKit'
  pod 'BSGUtilities', git: 'https://github.com/dirtyhenry/BSGUtilities.git', branch: 'main'

  target 'bootstragramTests' do
    inherit! :search_paths
  end
end

post_install do |pi|
  pi.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end