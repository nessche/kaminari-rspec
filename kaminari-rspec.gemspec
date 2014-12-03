# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'kaminari_rspec/version'

Gem::Specification.new do |s|
  s.name        = 'kaminari-rspec'
  s.version     = KaminariRspec::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Marco Sandrini']
  s.email       = %w(nessche@gmail.com)
  s.homepage    = 'https://github.com/nessche/kaminari-rspec'
  s.summary     = 'A Rspec Helper library for the Kaminari gem'
  s.description = 'A Rspec Helper library for the Kaminari gem'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)


  # specify any dependencies here; for example:
  s.add_runtime_dependency 'kaminari', '~> 0.16'
  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rr'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'flexmock'
end