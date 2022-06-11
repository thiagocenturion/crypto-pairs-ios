# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

workspace 'CryptoPairs.xcworkspace'
project 'CryptoPairs.xcodeproj'

def domain_pod
  pod 'Domain', :path => 'LocalPods/Domain', :testspecs => ['Tests']
end

def rxswift_pod
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
end

def development_pods
  domain_pod
end

target 'CryptoPairs' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for App
  development_pods

end

target 'CryptoPairsTests' do
  inherit! :search_paths
  # Pods for testing
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
