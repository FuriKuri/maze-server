# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maze/server/version'

Gem::Specification.new do |spec|
  spec.name          = 'maze-server'
  spec.version       = Server::VERSION
  spec.authors       = ['Theo Pack']
  spec.email         = %w(tf.pack@googlemail.com)
  spec.description   = %q{Maze server}
  spec.summary       = %q{Maze server}
  spec.homepage      = 'https://github.com/FuriKuri/maze-server'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
