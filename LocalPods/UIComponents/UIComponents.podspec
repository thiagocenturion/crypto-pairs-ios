#
# Be sure to run `pod lib lint UIComponents.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UIComponents'
  s.version          = '0.1.0'
  s.summary          = 'A short description of UIComponents.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/thiagocenturion/UIComponents'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'thiagocenturion' => 'thiagocenturion@me.com' }
  s.source           = { :git => 'https://github.com/thiagocenturion/UIComponents.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'

  s.source_files = 'UIComponents/Source/**/*.{swift}'
  s.resources = "UIComponents/Source/**/*.{xcassets, json, storyboard, xib, xcdatamodeld}"

  s.dependency 'Branding', '~> 0.1.0'
  
  # s.resource_bundles = {
  #   'UIComponents' => ['UIComponents/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
