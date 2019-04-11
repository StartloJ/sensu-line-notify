lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require_relative 'lib/sensu-plugins-linenoti'

Gem::Specification.new do |s|
  s.authors                = ['Watcharin YangNgam']
  s.date                   = Date.today.to_s
  s.description            = 'Sensu line notify plugins'
  s.email                  = '<watcharin@opsta.co.th>'
  s.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md CHANGELOG.md)
  s.homepage               = 'https://github.com/StartloJ/sensu-line-notify'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => 'StartloJ',
                               'development_status' => 'active',
                               'production_status'  => 'unstable - testing recommended',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false' }
  s.name                   = 'sensu-plugins-linenoti'
  s.platform               = Gem::Platform::RUBY
  s.post_install_message   = 'You can use the embedded Ruby by setting EMBEDDED_RUBY=true in /etc/default/sensu'
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 2.4.0'
  s.summary                = 'Sensu plugins for handle to line notify'
  s.test_files             = s.files.grep(%r{^(test|spec|features)/})
  s.version                = SensuPluginsLineNotify::Version::VER_STRING

  s.add_runtime_dependency 'sensu-plugin', '~> 2.0'
  s.add_runtime_dependency 'line_notify', '~> 1.0'

  s.add_development_dependency 'bundler',                   '~> 2.0'
  s.add_development_dependency 'github-markup',             '~> 3.0'
  s.add_development_dependency 'pry',                       '~> 0.10'
  s.add_development_dependency 'rake',                      '~> 12.3'
  s.add_development_dependency 'redcarpet',                 '~> 3.2'
  s.add_development_dependency 'rubocop',                   '~> 0.49.0'
  s.add_development_dependency 'rspec',                     '~> 3.4'
  s.add_development_dependency 'yard',                      '~> 0.9.11'
end