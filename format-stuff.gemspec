# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'format/stuff/version'

Gem::Specification.new do |spec|
  spec.name          = "format-stuff"
  spec.version       = Format::Stuff::VERSION
  spec.authors       = ["Christian Köstlin"]
  spec.email         = ["christian.koestlin@gmail.com"]

  spec.summary       = %q{Formats your stuff}
  spec.description   = %q{Formats your stuff.}
  spec.homepage      = "https://github.com/gizmomogwai/format-stuff"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
