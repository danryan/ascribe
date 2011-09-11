require 'rubygems'
require 'spork'

Spork.prefork do 
  require 'rspec'
  $: << File.join(File.dirname(__FILE__), "../lib")
  require 'ascribe'
  
  support_files = File.join(File.expand_path(File.dirname(__FILE__)), "spec/support/**/*.rb")
  Dir[support_files].each {|f| require f}

  RSpec.configure do |config|
    config.color_enabled = true
    config.mock_with :rspec
    
  end
end

Spork.each_run do
  
end