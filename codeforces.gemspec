# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codeforces/version'

Gem::Specification.new do |spec|
  spec.name          = "codeforces"
  spec.version       = Codeforces::VERSION
  spec.authors       = ["Hiroyuki Sano"]
  spec.email         = ["sh19910711@gmail.com"]
  spec.summary       = %q{The Wrapper Library for Codeforces API.}
  spec.homepage      = "https://github.com/sh19910711/codeforces-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_runtime_dependency "sawyer", "~> 0.6"
  spec.add_runtime_dependency "addressable", "~> 2.3"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "codeclimate-test-reporter"

  if ENV["CODEFORCES_DEBUG"] === "yes"
    spec.add_development_dependency "byebug"
  end
end
