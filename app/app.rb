#!/usr/bin/ruby
require "bundler/setup"
require 'sinatra'
require 'net/http'
require 'json'

require_relative 'models/init'

class MainApp < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/api/proxy/*' do
    channel = params[:splat][0]
    datafetch = Datafetch.new()
    res = datafetch.getData(channel)
    # error
    if res.nil? then
      status 404
      "Not Found"
      return false
    end

    #output
    status 200
    content_type "text/javascript"
    res
  end

  get '/api/getLatestProducts' do
    datafetch = Datafetch.new()
    limit = params['limit'] ? params['limit'].to_i : 3
    res = datafetch.getLatestProducts(limit)
    res
  end

end
