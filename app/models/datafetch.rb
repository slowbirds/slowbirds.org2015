class Datafetch
  def getData(channel)
    config = '{
      "vimeo":"http://vimeo.com/api/v2/slowbirds/videos.json",
      "soundcloud":"https://api.soundcloud.com/tracks?client_id=660f0a677cd5572e6c06dc951c79d052"
    }';

    apis = JSON.parse(config)

    if !apis[channel] then
      return {
        status:404,
        body:"Not Found",
        "Content-type"=>"text/plain"
      }
    end

    uri = URI.parse(apis[channel])
    res = Net::HTTP.get_response(uri)

    return res
  end
end
