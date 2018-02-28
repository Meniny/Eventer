Pod::Spec.new do |s|
  s.name        = 'Eventer'
  s.module_name = 'Eventer'
  s.version     = '1.1.0'
  s.summary     = 'Event bus for iOS.'

  s.homepage    = 'https://github.com/Meniny/Eventer'
  s.license     = { type: 'MIT', file: 'LICENSE.md' }
  s.authors     = { 'Elias Abel' => 'admin@meniny.cn' }
  s.social_media_url = 'https://meniny.cn/'
  # s.screenshot = ''

  s.ios.deployment_target     = '8.0'

  s.requires_arc        = true
  s.source              = { git: 'https://github.com/Meniny/Eventer.git', tag: s.version.to_s }
  s.source_files        = 'Eventer/**/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.swift_version       = '4.0'
  # s.documentation_url   = 'https://meniny.cn/Eventer/docs'
  s.frameworks          = 'Foundation'
end
