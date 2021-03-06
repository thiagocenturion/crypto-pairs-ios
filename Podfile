# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

workspace 'CryptoPairs.xcworkspace'
project 'CryptoPairs.xcodeproj'

def domain_pod
  pod 'Domain', :path => 'LocalPods/Domain', :testspecs => ['Tests']
end

def networking_pod
  pod 'Networking', :path => 'LocalPods/Networking'
end

def uicomponents_pod
  pod 'UIComponents', :path => 'LocalPods/UIComponents'
end

def branding_pod
  pod 'Branding', :path => 'LocalPods/Branding'
end

def development_pods
  domain_pod
  networking_pod
  uicomponents_pod
end

def rxswift_pod
  pod 'RxSwift', '6.0'
  pod 'RxCocoa', '6.0'
end

def rxmoya_pod
  pod 'Moya/RxSwift', '~> 15.0'
end

target 'CryptoPairs' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for App
  development_pods
  rxswift_pod
  rxmoya_pod
  pod 'Kingfisher', '~> 7.0'
  pod 'RxReachability', '~> 1.2.1'

  target 'CryptoPairsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '6.0'
    pod 'RxTest', '6.0'
  end

  target 'CryptoPairsSnapshotTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'SnapshotTesting', '~> 1.9.0'
  end
end

target 'Domain_Example' do
  use_frameworks!
  project 'LocalPods/Domain/Example/Domain.xcodeproj'

  domain_pod
  rxswift_pod
end

target 'Networking_Example' do
  use_frameworks!
  project 'LocalPods/Networking/Example/Networking.xcodeproj'

  networking_pod
  rxswift_pod
  rxmoya_pod
end

target 'UIComponents_Example' do
  use_frameworks!
  project 'LocalPods/UIComponents/Example/UIComponents.xcodeproj'

  uicomponents_pod
  branding_pod
end

target 'Branding_Example' do
  use_frameworks!
  project 'LocalPods/Branding/Example/Branding.xcodeproj'

  branding_pod
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'Yes'
        end
    end
end
