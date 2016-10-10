lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dockerlib/remote/version'

Gem::Specification.new do |s|
  s.name = 'dockerlib-remote'
  s.version = Dockerlib::Remote::VERSION

  s.summary = 'Docker remote api'
  s.description = s.summary
  s.homepage = 'https://github.com/flant/dockerlib-remote'

  s.authors = ['flant']
  s.email = ['256@flant.com']
  s.license = 'MIT'

  s.files = Dir['lib/**/*']

  s.required_ruby_version = '>= 2.1'

  s.add_dependency 'excon', '>= 0.45.4', '< 1.0'
  s.add_dependency 'net_status', '>= 0.1.2', '< 1.0'

  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
  s.add_development_dependency 'pry', '>= 0.10.3', '< 1.0'
  s.add_development_dependency 'pry-stack_explorer', '>= 0.4.9.2', '< 1.0'
  s.add_development_dependency 'travis', '~> 1.8', '>= 1.8.2'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.5'
end
