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
    if res["Content-Type"] == "application/json" then
      res["Content-Type"] = "text/javascript"
    end
    #output
    status res.code
    content_type res["Content-type"]
    res.body
  end

end
