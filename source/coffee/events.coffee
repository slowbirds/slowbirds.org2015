json = 'http://www.google.com/calendar/feeds/4meuj23muscevi0rhh5ima9gi0%40group.calendar.google.com/public/basic?alt=json-in-script&callback=gcal&orderby=starttime&sortorder=ascending&futureevents=true&max-results=3'

setTimeout () ->
  s = document.createElement "script"
  s.src = json
  s.type = "text/javascript"
  document.body.appendChild s
, 0

@gcal = (feed) ->
  events = feed.feed.entry
  for event in events
    console.log event.title.$t
    console.log event.content.$t
  console.log feed.feed
