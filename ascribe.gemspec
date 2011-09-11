# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ascribe/version"

Gem::Specification.new do |s|
  s.name        = "ascribe"
  s.version     = Ascribe::VERSION
  s.authors     = ["Dan Ryan"]
  s.email       = ["dan@appliedawesome.com"]
  s.homepage    = "https://github.com/danryan/ascribe"
  s.summary     = %q{Attributes for your Ruby objects}
  s.description = %q{}

  s.rubyforge_project = "ascribe"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activemodel', '>= 3.0.10'
  s.add_dependency 'yajl-ruby', '>= 0.8.2'
  s.add_dependency 'rake', '>= 0.9.2'
  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
