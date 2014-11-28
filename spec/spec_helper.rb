ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '../app', 'app.rb')

require 'rspec'
require 'rack/test'
require 'simplecov'
require 'coveralls'
Coveralls.wear!('rails')

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start 'rails'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  Server
end
