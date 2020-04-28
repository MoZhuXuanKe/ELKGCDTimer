#
# Be sure to run `pod lib lint ELKGCDTimer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ELKGCDTimer'
  s.version          = '0.1.0'
  s.summary          = 'ELKGCDTimer 是一个简单易用的GCD定时器'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'ELKGCDTimer 是一个简单易用的GCD定时器,可以手动的管理,暂停,恢复,销毁等操作.在指定定时次数时,会在完成任务后自动销毁,如果是指定无限次数时,需要用户手动销毁.'

  s.homepage         = 'https://github.com/MoZhuXuanKe/ELKGCDTimer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MoZhuXuanKe' => 'mozhuxuanke@icloud.com' }
  s.source           = { :git => 'https://github.com/MoZhuXuanKe/ELKGCDTimer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ELKGCDTimer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ELKGCDTimer' => ['ELKGCDTimer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
