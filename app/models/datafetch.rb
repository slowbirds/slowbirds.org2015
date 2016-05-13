require 'time'
require 'cgi'
require 'json'

class Datafetch

  def initialize()
    @now = Time.now
    @cacheDir =  File.expand_path(File.dirname(File.dirname(File.dirname(__FILE__)))) + "/cache"
  end

  def getData(channel)
    now_iso = CGI.escape(@now.iso8601)
    apis = {
      'vimeo'=>"http://vimeo.com/api/v2/slowbirds/videos.json",
      'soundcloud'=>"http://api.soundcloud.com/users/slowbirds/tracks.json?client_id=660f0a677cd5572e6c06dc951c79d052",
      'mixcloud' =>"http://api.mixcloud.com/slowbirds/cloudcasts/",
      'gcal'=>"https://www.googleapis.com/calendar/v3/calendars/4meuj23muscevi0rhh5ima9gi0%40group.calendar.google.com/events?key=AIzaSyCPEFbmlTpjI_7xHAladCnC7Tsn7F2QDeU&orderBy=startTime&singleEvents=true&timeZone=Asia%2FSaigon&maxResults=3&timeMin=#{now_iso}"
    }
    # undefined channel
    if !apis[channel] then
      return nil
    end

    # cached data
    cache = isCached(channel)
    if cache != nil then
      return cache
    end

    # new data fetching
    res = requestApi(apis[channel])
    cacheData(channel, res.body)
    return res.body
  end

  def requestApi(url)
    uri = URI.parse(url)
    res = Net::HTTP.get_response(uri)
    return res
  end

  def cacheData(channel, json)
    timestamp = @now.strftime("%Y%m%d%H")
    cachelog = "#{@cacheDir}/#{channel}_log.txt"
    filename = "#{@cacheDir}/#{channel}.json"
    File.open(cachelog, "w") do |file|
      file.write(timestamp)
    end
    File.open(filename, "w") do |file|
      file.write(json)
    end
    return json
  end

  def isCached(channel)
    timestamp = @now.strftime("%Y%m%d%H")
    cachelog = "#{@cacheDir}/#{channel}_log.txt"
    filename = "#{@cacheDir}/#{channel}.json"
    cached_time = "000000"
    if File.exist?(cachelog) then
      File.open(cachelog,"r") do |file|
        cached_time = file.read
      end
    end

    if cached_time == timestamp then
       return File.read(filename, :encoding => Encoding::UTF_8)
    end

    return nil
  end

  def parseVimeo(max=10)
    vimeo = JSON.parse(getData('vimeo'))
    count = 0
    ret = Array.new
    vimeo.each do |item|
      ret[count] = {
        'title'     => item['title'],
        'date'      => item['upload_date'],
        'timestamp' => item['upload_date'].gsub(/([^0-9])/,""),
        'url'       => item['url'],
        'desc'      => item['description'],
        'thumbnail' => item['thumbnail_medium'].gsub(/_200x150/,"_300x300"),
        'tags'      => item['tags'],
        'channel'   => 'vimeo'
      }
      if count >= max then
        break
      end
      count += 1
    end
    return ret
  end

  def parseSoundcloud(max=10)
    sc = JSON.parse(getData('soundcloud'))
    count = 0
    ret = Array.new
    sc.each do |item|
      ret[count] = {
        'title'     => item['title'],
        'date'      => item['created_at'].gsub(/\//,"-").gsub(/ \+0000$/,""),
        'timestamp' => item['created_at'].gsub(/ \+0000$/,"").gsub(/([^0-9])/,""),
        'url'       => item['permalink_url'],
        'desc'      => item['description'],
        'thumbnail' => item['artwork_url'],
        'tags'      => item['tag_list'].gsub(/ /, ","),
        'channel'   => 'soundcloud'
      }
      if count >= max then
        break
      end
      count += 1
    end
    return ret
  end

  def parseMixcloud(max=10)
    sc = JSON.parse(getData('mixcloud'))
    count = 0
    ret = Array.new
    sc['data'].each do |item|
      tags = ""
      item['tags'].each do |tagval|
        tags = "#{tags},#{tagval['name']}"
      end
      ret[count] = {
        'title'     => item['name'],
        'date'      => item['created_time'].gsub(/T/," ").gsub(/Z$/,""),
        'timestamp' => item['created_time'].gsub(/([^0-9])/,""),
        'url'       => item['url'],
        'desc'      => "",
        'thumbnail' => item['pictures']['large'],
        'tags'      => tags,
        'channel'   => 'mixcloud'
      }
      if count >= max then
        break
      end
      count += 1
    end
    return ret
  end

  def getLatestProducts(max)
    vimeo = parseVimeo(max)
    sc = parseSoundcloud(max)
    mc = parseMixcloud(max)
    json = vimeo.concat(sc).concat(mc)
    ret = json.sort_by { |hash| -hash['timestamp'].to_i }
    return ret.to_json
  end

end
