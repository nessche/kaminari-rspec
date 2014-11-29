require 'rspec'


# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.color     = true
  config.formatter = 'documentation'

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end