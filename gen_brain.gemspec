# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gen_brain/version"

Gem::Specification.new do |spec|
  spec.name          = "gen_brain"
  spec.version       = GenBrain::VERSION
  spec.authors       = ["284km"]
  spec.email         = ["k.furuhashi10@gmail.com"]

  spec.summary       = %q{Generate subspecies of brainf*ck.}
  spec.description   = %q{Generate subspecies of brainf*ck.}
  spec.homepage      = "https://github.com/284km/gen_brain"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
