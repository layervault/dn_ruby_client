# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'designer_news/version'

Gem::Specification.new do |spec|
  spec.name          = "dn"
  spec.version       = DesignerNews::VERSION
  spec.authors       = ["Kelly Sutton"]
  spec.email         = ["kelly@layervault.com"]
  spec.description   = %q{The Designer News Ruby API client.}
  spec.summary       = %q{Provides Ruby native wrappers for the Designer News API.}
  spec.homepage      = "https://github.com/layervault/dn_ruby_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "hashie"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "multi_json"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", "1.13"
end
