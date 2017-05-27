# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "starling/version"

Gem::Specification.new do |spec|
  spec.name          = "starling"
  spec.version       = Starling::VERSION
  spec.authors       = ["Nick Charlton"]
  spec.email         = ["nick@nickcharlton.net"]

  spec.summary       = "Starling is a client library for the " \
                          "Starling Bank API."
  spec.homepage      = "https://github.com/nickcharlton/starling"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
