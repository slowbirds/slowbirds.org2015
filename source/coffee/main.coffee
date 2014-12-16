# helper class
Helper = require './helper'
window.helper = new Helper()

# Mainvisual class
Mainvisual = require './mainvisual'
mainvisual = new Mainvisual(helper.$id 'mainvisual')
mainvisual.addEvent

# upcoming events class
Upcoming = require './upcoming'
upcoming = new Upcoming()
upcoming.getList helper.$id "events"
