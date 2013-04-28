# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'finances/version'

Gem::Specification.new do |spec|
  spec.name          = "finances"
  spec.version       = Finances::VERSION
  spec.authors       = ["Steve Jackson"]
  spec.email         = ["steve.jackson@leandogsoftware.com"]
  spec.description   = %q{Applying Clean Architecture principles (Uncle Bob) to manage my household finances}
  spec.summary       = %q{Manage household finances}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.files.reject! { |fn| fn.start_with? 'delivery' or fn.start_with? 'gateway' }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "require_all"
  spec.add_dependency "ofx"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
