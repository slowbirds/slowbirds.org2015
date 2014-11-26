require 'time'
require 'cgi'

class Datafetch
  def getData(channel)
    now_iso = CGI.escape(Time.now.iso8601)
    apis = {
      'vimeo'=>"http://vimeo.com/api/v2/slowbirds/videos.json",
      'soundcloud'=>"https://api.soundcloud.com/tracks?client_id=660f0a677cd5572e6c06dc951c79d052",
      'gcal'=>"https://www.googleapis.com/calendar/v3/calendars/4meuj23muscevi0rhh5ima9gi0%40group.calendar.google.com/events?key=AIzaSyCPEFbmlTpjI_7xHAladCnC7Tsn7F2QDeU&orderBy=startTime&singleEvents=true&timeZone=Asia%2FSaigon&maxResults=3&timeMin=#{now_iso}"
    }

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
