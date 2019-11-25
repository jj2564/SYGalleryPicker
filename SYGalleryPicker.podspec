#
# Be sure to run `pod lib lint SYGalleryPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SYGalleryPicker'
  s.version          = '1.0.0'
  s.summary          = 'A photo library can fit Sinyi Project.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jj2564/SYGalleryPicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jj2564' => 'jamek8@gmail.com' }
  s.source           = { :git => 'https://github.com/jj2564/SYGalleryPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jj2564'

  s.source_files = 'SYGalleryPicker/Classes/**/*'
  
  s.ios.deployment_target = '10.0'
  s.swift_version = "5.1"
  s.frameworks = 'UIKit', 'Photos'
  
  # s.resource_bundles = {
  #   'SYGalleryPicker' => ['SYGalleryPicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

end
