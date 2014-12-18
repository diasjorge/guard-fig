# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/fig/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-fig"
  spec.version       = Guard::Fig::VERSION
  spec.authors       = ["Jorge Dias"]
  spec.email         = ["jorge.dias@xing.com"]
  spec.summary       = %q{Guard gem for Fig}
  spec.description   = %q{Guard::Fig helps you develop docker containers faster using fig}
  spec.homepage      = "https://rubygems.org/gems/guard-fig"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
