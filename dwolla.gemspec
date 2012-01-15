# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dwolla/version"

Gem::Specification.new do |s|
  s.name        = "dwolla"
  s.version     = Dwolla::VERSION
  s.authors     = ["Jefferson Girao"]
  s.email       = ["contato@jefferson.eti.br"]
  s.homepage    = "https://github.com/jeffersongirao/dwolla"
  s.summary     = %q{A Ruby wrapper for the Dwolla API.}
  s.description = %q{A Ruby wrapper for the Dwolla API.}

  s.rubyforge_project = "dwolla"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'jeffersongirao_faraday-stack'
  s.add_dependency 'multi_json'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'simplecov'
end
