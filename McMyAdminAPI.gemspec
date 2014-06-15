# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'McMyAdminAPI/version'

Gem::Specification.new do |spec|
  spec.name          = "McMyAdminAPI"
  spec.version       = McMyAdminAPI::VERSION
  spec.authors       = ["Julian Nadeau", "Lucas Marcelli"]
  spec.email         = ["contact@codeforkids.com"]
  spec.summary       = "A Ruby API Wrapper for the McMyAdmin v2 API."
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
