#
# Be sure to run `pod lib lint JMColorPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JMColorPicker'
  s.version          = '0.1.0'
  s.summary          = 'JMColorPicker provides the simple way of selecting color from color picker by sliding the UISlider control.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
JMColorPicker provides the simple way of selecting color from color picker by sliding the UISlider control. Install pod into your project to use the generic color picking for your usage.
                       DESC

  s.homepage         = 'https://github.com/JayachandraA/JMColorPicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JayachandraA' => 'ajchandra15@gmail.com' }
  s.source           = { :git => 'https://github.com/JayachandraA/JMColorPicker.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ajchandra15'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JMColorPicker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JMColorPicker' => ['JMColorPicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
