Pod::Spec.new do |s|
  s.name = 'Cub'
  s.version = '0.7.1'
  s.license = 'MIT'
  s.summary = 'The Cub Programming Language'
  s.homepage = 'https://github.com/louisdh/cub'
  s.social_media_url = 'http://twitter.com/LouisDhauwe'
  s.authors = { 'Louis D\'hauwe' => 'louisdhauwe@silverfox.be' }
  s.source = { :git => 'https://github.com/louisdh/cub.git', :tag => s.version }
  s.module_name  = 'Cub'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target  = '10.12'

  s.source_files = 'Sources/**/*.swift'
  s.resources = 'Sources/**/*.cub'

end
