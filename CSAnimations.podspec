Pod::Spec.new do |s|
  s.name         = 'CSAnimations'
  s.summary      = 'Animations for iOS.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'CoderXSLee' => '1363852560@qq.com' }
# s.social_media_url = 'http://blog.ibireme.com'
  s.homepage     = 'https://github.com/CoderXSLee/CSAnimations'
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/CoderXSLee/CSAnimations.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'CSAnimations/*.{h,m}'
  s.public_header_files = 'CSAnimations/*.{h}'

  s.frameworks = 'UIKit', 'CoreGraphics'
# s.dependency '', '~> *.*.*'

end
