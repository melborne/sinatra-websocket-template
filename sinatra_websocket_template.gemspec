# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra_websocket_template/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra_websocket_template"
  spec.version       = SinatraWebsocketTemplate::VERSION
  spec.authors       = ["kyoendo"]
  spec.email         = ["postagie@gmail.com"]
  spec.description   = %q{Generate a skeleton of WebSocket application with Ruby(Sinatra)}
  spec.summary       = %q{Generate a skeleton of WebSocket application with Ruby(Sinatra)}
  spec.homepage      = "https://github.com/melborne/sinatra-websocket-template"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0.0"

  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
