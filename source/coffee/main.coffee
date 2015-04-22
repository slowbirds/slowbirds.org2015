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


# navigation effects
nav    = helper.$id "navigation"
target = nav.getElementsByTagName 'a'
for element in target
  element.addEventListener "mouseover", (e)->
    for element in target
      if this != element
        element.className = "unfocus"
  element.addEventListener "mouseout", (e)->
    for element in target
      element.className = "focus"
