source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

target 'ProjectWaterBottle' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ProjectWaterBottle
    pod 'Alamofire'
    pod 'SwiftyJSON'

  target 'ProjectWaterBottleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ProjectWaterBottleUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'WaterBottleCard' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WaterBottleCard
  pod 'Alamofire'
  pod 'SwiftyJSON'

  target 'WaterBottleCardTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'WaterBottleExtension' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WaterBottleExtension
  #pod 'Alamofire', '~> 4.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
