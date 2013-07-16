require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'
require 'yard/rake/yardoc_task'

task :spec  => [:spec_common, :spec_with_rspec, :spec_with_mocha, :spec_with_flexmock]

YARD::Rake::YardocTask.new('yard')

desc 'Runs the specs that are common to all mocking mechanisms'
RSpec::Core::RakeTask.new(:spec_common) do |t|
  t.pattern = 'spec/lib/kaminari_rspec/test_helpers_spec.rb'
end

desc 'Runs the specs that need the built-in RSpec mocking mechanism'
RSpec::Core::RakeTask.new(:spec_with_rspec) do |t|
  t.pattern = 'spec/lib/kaminari_rspec/rspec/test_helpers_spec.rb'
end

desc 'Runs the specs that need the rr mocking mechanism'
RSpec::Core::RakeTask.new(:spec_with_rr) do |t|
  t.pattern = 'spec/lib/kaminari_rspec/rr/test_helpers_spec.rb'
end

desc 'Runs the specs that need the mocha mocking mechanism'
RSpec::Core::RakeTask.new(:spec_with_mocha) do |t|
  t.pattern = 'spec/lib/kaminari_rspec/mocha/test_helpers_spec.rb'
end

desc 'Runs the specs that need the flexmock mocking mechanism'
RSpec::Core::RakeTask.new(:spec_with_flexmock) do |t|
  t.pattern = 'spec/lib/kaminari_rspec/flexmock/test_helpers_spec.rb'
end

task :default => :spec