# helper class
Helper = require './helper'
window.helper = new Helper()

# Mainvisual class
Mainvisual = require './mainvisual'
mainvisual = new Mainvisual(document.getElementById 'mainvisual')

# upcoming events class
Upcoming = require './upcoming'
upcoming = new Upcoming(document.getElementById "events")
