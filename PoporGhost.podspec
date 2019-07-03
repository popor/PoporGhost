#
# Be sure to run `pod lib lint PoporGhost.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PoporGhost'
  s.version          = '0.1.02'
  s.summary          = 'PoporGhost: 方便测试数据, 将测试数据转变为dic,通过yyCache保存到磁盘,可以在下一次恢复,适用于大量输入数据的情况.'
  
  s.homepage         = 'https://github.com/popor/PoporGhost'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'popor' => '908891024@qq.com' }
  s.source           = { :git => 'https://github.com/popor/PoporGhost.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '6.0'
  
  s.source_files = 'Example/Classes/PoporGhost/*.{h,m}'
  #s.source_files = 'PoporGhost/Classes/**/*'
  
  s.dependency 'YYModel'
  s.dependency 'YYCache'
  s.dependency 'Masonry'
  s.dependency 'PoporFoundation/NSDate'
  
end
