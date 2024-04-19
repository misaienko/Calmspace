# Podfile

platform :ios, '16.4'

target 'Calmspace' do
  use_frameworks!

  # Pods for Calmspace
  pod 'FSCalendar'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == "FSCalendar"
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.4'
        end
      end
    end
  end

  target 'CalmspaceTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CalmspaceUITests' do
    # Pods for testing
  end
end
