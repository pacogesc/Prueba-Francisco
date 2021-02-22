# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Prueba conocimientos Francisco' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Prueba conocimientos Francisco
  pod 'JGProgressHUD', '2.2'
  pod 'LBTATools', '1.0.12'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
    end
  end
end
