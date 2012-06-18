# -*- encoding: utf-8 -*-
require File.expand_path('../lib/kamel/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Xavier Shay"]
  gem.email         = ["contact@rhnh.net"]
  gem.description   = %q{Create KML files for tasty overlays on google earth and google maps}
  gem.summary       = %q{Create KML files for tasty overlays on google earth and google maps}
  gem.homepage      = "http://github.com/xaviershay/lesstile"

  gem.required_ruby_version     = ">= 1.8.7"
  gem.rubyforge_project         = "kamel"

  gem.add_development_dependency "rspec", "~> 2.9"
  gem.add_development_dependency 'rake', '~> 0.9'

  gem.add_runtime_dependency 'ruby_kml', '~> 0.1.4'
  gem.add_runtime_dependency 'builder', '~> 3.0.0' #ruby_kml depends on builder but does not declare it's dependencies correctly

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "kamel"
  gem.require_paths = ["lib"]
  gem.version       = Kamel::VERSION
end
