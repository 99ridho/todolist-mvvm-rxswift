# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Todolist-MVVM' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Todolist-MVVM
  pod 'RxSwift',    '~> 3.0'
  pod 'RxCocoa',    '~> 3.0'

  target 'Todolist-MVVMTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 3.0'
    pod 'RxTest',     '~> 3.0'
  end

  target 'Todolist-MVVMUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end
