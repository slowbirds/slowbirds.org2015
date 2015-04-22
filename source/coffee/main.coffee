# helper class
Helper = require './helper'
window.helper = new Helper()

# upcoming events class
#Upcoming = require './upcoming'
#upcoming = new Upcoming()
#upcoming.getList helper.$id "events"

# products class
Products = require './products'
products = new Products()
products.getList helper.$id "products"
