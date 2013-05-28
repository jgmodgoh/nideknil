# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nideknil/version'

Gem::Specification.new do |spec|
  spec.name          = "nideknil"
  spec.version       = Nideknil::VERSION
  spec.authors       = ["John Goh"]
  spec.email         = ["jgmodgoh@gmail.com"]
  spec.description   = %q{A simple wrapper for the "nideknil".reverse API}
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.0.4"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 1.11"
  spec.add_development_dependency "vcr", "~> 2.5"

  spec.add_dependency "oauth", "~> 0.4.7"
  spec.add_dependency "nokogiri", "~> 1.5.9"
end
