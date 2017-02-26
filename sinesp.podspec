#
# Be sure to run `pod lib lint sinesp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'sinesp'
  s.version          = '0.1.0'
  s.summary          = 'Swift wrapper of SINESP API (Brazilian National Public Security Information System)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A SINESP API Client that allows you to get information about brazilian vehicles (using their license plate).
                       DESC

  s.homepage         = 'https://github.com/fpg1503/sinesp-swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Francesco Perrotti-Garcia' => 'fpg1503@gmail.com' }
  s.source           = { :git => 'https://github.com/fpg1503/sinesp-swift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/fpg1503'

  s.ios.deployment_target = '8.0'

  s.source_files = 'sinesp/Classes/**/*'
  
  # s.resource_bundles = {
  #   'sinesp' => ['sinesp/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Arcane'
  s.dependency 'AEXML'
  s.dependency 'Regex.swift', '~> 0.1'

end
