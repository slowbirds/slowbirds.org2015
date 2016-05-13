# helper class
Helper = require './helper'
window.helper = new Helper()

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
