# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/untz/version'

Gem::Specification.new do |spec|
  spec.name          = 'minitest-untz'
  spec.version       = Minitest::Untz::VERSION
  spec.authors       = ['Ernie Miller']
  spec.email         = ['ernie@erniemiller.org']
  spec.summary       = %q{Like a rave every time you test.}
  spec.description   = %q{Colorizes test output and replaces output strings with sweet onomatopoeia.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'minitest'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'terminal-notifier-guard'
end
