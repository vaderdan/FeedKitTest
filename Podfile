platform :ios, '9.0'
target 'FeedKitTest' do
	pod 'FeedKit', :git => 'https://github.com/nmdias/FeedKit.git'
	pod 'Alamofire', '~> 4.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

use_frameworks!