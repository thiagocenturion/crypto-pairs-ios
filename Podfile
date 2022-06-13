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

def development_pods
  domain_pod
  networking_pod
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
  pod 'Kingfisher', '~> 7.0'
  pod 'RxReachability', '~> 1.2.1'
end

target 'CryptoPairsTests' do
  inherit! :search_paths
  # Pods for testing
  development_pods
  rxswift_pod
  rxmoya_pod
end

target 'CryptoPairsUITests' do
  # Pods for testing
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

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'Yes'
        end
    end
end
