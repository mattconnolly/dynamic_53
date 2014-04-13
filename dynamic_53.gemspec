# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dynamic_53/version'

Gem::Specification.new do |spec|
  spec.name          = "dynamic_53"
  spec.version       = Dynamic53::VERSION
  spec.authors       = ["Matt Connolly"]
  spec.email         = ["matt.connolly@me.com"]
  spec.summary       = %q{A simple tool to update Amazon Route 53 with based on your current IP Address.}
  spec.description   = %q{A simple tool to update Amazon Route 53 with based on your current IP Address.}
  spec.homepage      = "https://github.com/mattconnolly/dynamic_53"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "aws-sdk", "~> 1.38.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
