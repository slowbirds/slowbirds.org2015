require 'coveralls'
Coveralls.wear!

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '../app', 'app.rb')

require 'rspec'
require 'rack/test'
require 'simplecov'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Server
end
