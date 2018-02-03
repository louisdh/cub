Pod::Spec.new do |s|
  s.name = 'Lioness'
  s.version = '0.5.2'
  s.license = 'MIT'
  s.summary = 'The Lioness Programming Language'
  s.homepage = 'https://github.com/louisdh/lioness'
  s.social_media_url = 'http://twitter.com/LouisDhauwe'
  s.authors = { 'Louis D\'hauwe' => 'louisdhauwe@silverfox.be' }
  s.source = { :git => 'https://github.com/louisdh/lioness.git', :tag => s.version }
  s.module_name  = 'Lioness'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target  = '10.12'

  s.source_files = 'Sources/**/*.swift'
  s.resources = 'Sources/**/*.lion'

end
