Pod::Spec.new do |s|
  s.name         = 'JHViewCorner'
  s.summary      = "Set view's corner with one code!"
  s.version      = '1.2.2'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'Haocold' => 'xjh093@126.com' }
  s.homepage     = 'https://github.com/xjh093/JHViewCorner'

  s.ios.deployment_target = '8.0'

  s.source       = { :git => 'https://github.com/xjh093/JHViewCorner.git', :tag => s.version}
  
  s.source_files = 'JHViewCorner/*.{h,m}'
  s.requires_arc = true
  s.framework    = 'UIKit'

end
