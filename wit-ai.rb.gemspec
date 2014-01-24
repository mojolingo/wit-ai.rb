# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wit-ai/version'

Gem::Specification.new do |spec|
  spec.name          = "wit-ai.rb"
  spec.version       = WitAI::VERSION
  spec.authors       = ["Ben Langfeld"]
  spec.email         = ["ben@langfeld.me"]
  spec.summary       = %q{A client library for http://wit.ai.}
  spec.description   = %q{A client library for http://wit.ai.}
  spec.homepage      = "http://github.com/mojolingo/wit-ai.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "webmock"
end
