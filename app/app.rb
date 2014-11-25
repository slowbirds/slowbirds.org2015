#!/usr/bin/ruby
require "bundler/setup"
require 'sinatra'
require 'net/http'
require 'json'

require_relative 'models/init'

class Server < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/api/proxy/*' do
    channel = params[:splat][0]
    datafetch = Datafetch.new()
    res = datafetch.getData(channel)

    #output
    status res.code
    content_type res["Content-type"]
    res.body
  end

end
