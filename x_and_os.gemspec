# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'x_and_os/version'

Gem::Specification.new do |spec|
  spec.name          = "x_and_os"
  spec.version       = XAndOs::VERSION
  spec.authors       = ["Jonny"]
  spec.email         = ["jonny.adshead@gmail.com"]

  spec.summary       = %q{Tic tac toe command line game}
  spec.description   = %q{Basic modules that allow you to build a tic tac toe game and a small cla to play Tic Tac Toe in the command line}
  spec.homepage      = "http://github.com/JAdshead/xandos"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["x_and_os"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
