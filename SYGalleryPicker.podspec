#
# Be sure to run `pod lib lint SYGalleryPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SYGalleryPicker'
  s.version          = '1.2.3'
  s.summary          = 'A photo picker library. It can be customize for many places.'


  s.description      = <<-DESC
                       'SYGalleryPicker have three default style but first two is for my work. So just use basic style or customize your prefer style. So have fun with coding~'
                       DESC

  s.homepage         = 'https://github.com/jj2564/SYGalleryPicker'
  s.screenshots     = 'https://raw.githubusercontent.com/jj2564/SYGalleryPicker/master/screenshots/basic_style.png', 'https://raw.githubusercontent.com/jj2564/SYGalleryPicker/master/screenshots/album_switch.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jj2564' => 'jamek8@gmail.com' }
  s.source           = { :git => 'https://github.com/jj2564/SYGalleryPicker.git', :tag => s.version.to_s }
  
  s.social_media_url = 'https://twitter.com/jj2564'

  s.source_files = 'SYGalleryPicker/Classes/**/*'
  s.resource_bundles = {
    'SYGalleryPicker' => ['SYGalleryPicker/Assets/*']
  }
  s.ios.deployment_target = '10.0'
  s.swift_version = "5.1"
  s.frameworks = 'UIKit', 'Photos'

end
