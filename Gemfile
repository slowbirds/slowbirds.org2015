ruby '2.2.0'

source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'rack'
gem 'rack-test'

group :production do
  gem 'unicorn'
end

group :development do
    gem 'shotgun'
end

group :test, :development do
  gem 'rspec'
  gem 'coveralls', :require => false
  gem 'simplecov'
end
