# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sturnus/version"

Gem::Specification.new do |spec|
  spec.name          = "sturnus"
  spec.version       = Sturnus::VERSION
  spec.authors       = ["Nick Charlton"]
  spec.email         = ["nick@nickcharlton.net"]

  spec.summary       = "Sturnus is a client library for the " \
                          "Starling Bank API."
  spec.homepage      = "https://github.com/nickcharlton/sturnus"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth2"
  spec.add_dependency "virtus"
  spec.add_dependency "representable"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
