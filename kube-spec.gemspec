$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'kube-spec/version'

Gem::Specification.new do |s|
  s.name     = 'kube-spec'
  s.version  = ::KubeSpec::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/getkuby/kube-spec'

  s.description = s.summary = 'A mock Kubernetes client and server (plus matchers) for RSpec.'

  s.platform = Gem::Platform::RUBY

  s.add_dependency 'rspec', '~> 3.0'
  s.add_dependency 'kubectl-rb', '~> 0.1'
  s.add_dependency 'kube-dsl', '~> 0.3'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'kube-spec.gemspec']
end
