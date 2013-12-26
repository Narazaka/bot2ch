# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bot2ch/version'

Gem::Specification.new do |spec|
  spec.name          = "bot2ch"
  spec.version       = Bot2ch::VERSION
  spec.authors       = ["Manbo-"]
  spec.email         = ["manbo-@server.fake"]
  spec.description   = %q{2ch}
  spec.summary       = %q{2ch}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rainbow"

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "libnotify"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
