#!/usr/bin/ruby
require "bundler/setup"
require 'sinatra'
require 'net/http'
require 'json'

config = '{
  "vimeo":"http://vimeo.com/api/v2/slowbirds/videos.json",
  "soundcloud":"https://api.soundcloud.com/tracks?client_id=660f0a677cd5572e6c06dc951c79d052"
}';

get '/' do
  erb :index
end

get '/api/proxy/*' do
  channel = params[:splat][0]

  apis = JSON.parse(config)

  if !apis[channel] then
    status 404
    return "Not Found"
  end

  uri = URI.parse(apis[channel])
  res = Net::HTTP.get_response(uri)

  if res.code=="200" then
    content_type res['Content-type']
    res.body
  else
    status res.code
    return res.code
  end
end
